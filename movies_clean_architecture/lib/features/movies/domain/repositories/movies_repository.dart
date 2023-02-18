import 'package:dartz/dartz.dart';
import 'package:movies_clean_architecture/core/errors/failures.dart';
import 'package:movies_clean_architecture/features/movies/domain/entities/movie.dart';

abstract class MoviesRepository {
  Future<Either<Failure, List<Movie>>> getMovies();
  Future<Either<Failure, List<Movie>>> getPopularMovies(int page);
}
