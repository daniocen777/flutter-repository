import '../../../domain/datasources/local/movies_local_datasource.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/repositories/local/movies_local_repository.dart';

class MovieLocalStorageRepositoryImpl extends MoviesLocalRepository {
  MovieLocalStorageRepositoryImpl({required this.datasource});

  final MoviesLocalDatasource datasource;

  @override
  Future<bool> isMovieFavorite(int movieId) {
    return datasource.isMovieFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    return datasource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorites(Movie movie) {
    return datasource.toggleFavorites(movie);
  }
}
