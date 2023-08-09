import '../either/either.dart';
import '../failures/http_request/http_request_failure.dart';
import '../models/movie/movie.dart';
import '../models/performer/performer.dart';

abstract class MovieRepository {
  Future<Either<HttpRequestFailure, Movie>> getMovieById(int id);

  Future<Either<HttpRequestFailure, List<Performer>>> getCastByMovie(int id);
}
