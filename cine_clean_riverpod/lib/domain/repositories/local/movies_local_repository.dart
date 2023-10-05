import '../../entities/movie.dart';

abstract class MoviesLocalRepository {
  Future<void> toggleFavorites(Movie movie);

  Future<bool> isMovieFavorite(int movieId);

  // con paginacion
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
}
