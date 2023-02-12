import 'package:dartz/dartz.dart';
import 'package:movies_clean_architecture/core/errors/failures.dart';
import 'package:movies_clean_architecture/features/movies/domain/entities/movie.dart';
import 'package:movies_clean_architecture/features/movies/domain/repositories/movies_repository.dart';

class GetMoviesUserCase {
  final MoviesRepository repository;

  GetMoviesUserCase(this.repository);

  Future<Either<Failure, List<Movie>>> call() async {
    return await repository.getMovies();
  }
}
