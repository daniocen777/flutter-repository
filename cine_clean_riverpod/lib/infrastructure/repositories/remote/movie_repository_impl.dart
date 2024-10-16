import '../../../domain/datasources/remote/movies_datasource.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/repositories/remote/movie_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  MovieRepositoryImpl(this.datasource);

  final MoviesDatasource datasource;

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }

  @override
  Future<Movie> getMovieByID(String id) {
    return datasource.getMovieByID(id);
  }

  @override
  Future<List<Movie>> searchMovie(String query) {
    return datasource.searchMovie(query);
  }
}
