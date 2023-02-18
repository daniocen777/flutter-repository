import 'package:dartz/dartz.dart';
import 'package:movies_clean_architecture/core/errors/failures.dart';
import 'package:movies_clean_architecture/features/movies/domain/entities/movie.dart';
import 'package:movies_clean_architecture/features/movies/domain/repositories/movies_repository.dart';

class GetPopularMoviesUseCase {
  final MoviesRepository repository;

  GetPopularMoviesUseCase(this.repository);

  Future<Either<Failure, List<Movie>>> call(int page) async {
    return await repository.getPopularMovies(page);
  }
}
