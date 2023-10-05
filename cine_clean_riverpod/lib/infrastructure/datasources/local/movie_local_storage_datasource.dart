import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../../domain/datasources/local/movies_local_datasource.dart';
import '../../../domain/entities/movie.dart';

class MovieLocalStorageDatasource extends MoviesLocalDatasource {
  MovieLocalStorageDatasource() {
    db = openDB();
  }

  late Future<Isar> db;

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final path = (await getApplicationDocumentsDirectory()).path;
      return await Isar.open([MovieSchema], directory: path, inspector: true);
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db; // esperar que la bd este lista
    final Movie? favoriteMovie =
        await isar.movies.filter().idEqualTo(movieId).findFirst();
    return favoriteMovie != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    final isar = await db; // esperar que la bd este lista
    return isar.movies.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<void> toggleFavorites(Movie movie) async {
    final isar = await db; // esperar que la bd este lista
    final Movie? favoriteMovie =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();
    if (favoriteMovie != null) {
      // eliminar
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));
    }
    // Insertar
    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }
}
