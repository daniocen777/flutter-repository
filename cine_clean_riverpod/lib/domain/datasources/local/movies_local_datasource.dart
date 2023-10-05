import '../../entities/movie.dart';

abstract class MoviesLocalDatasource {
  Future<void> toggleFavorites(Movie movie);

  Future<bool> isMovieFavorite(int movieId);

  // con paginacion
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
}
