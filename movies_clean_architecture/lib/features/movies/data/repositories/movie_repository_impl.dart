import 'package:dartz/dartz.dart';
import 'package:movies_clean_architecture/core/errors/exceptions.dart';
import 'package:movies_clean_architecture/core/network/network_info.dart';
import 'package:movies_clean_architecture/features/movies/data/datasources/movie_remote_datasource.dart';

import 'package:movies_clean_architecture/features/movies/domain/entities/movie.dart';
import 'package:movies_clean_architecture/core/errors/failures.dart';
import 'package:movies_clean_architecture/features/movies/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl implements MoviesRepository {
  final MovieRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  MovieRepositoryImpl(
      {required this.remoteDatasource, required this.networkInfo});

  @override
  Future<Either<Failure, List<Movie>>> getMovies() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMovies = await remoteDatasource.getAllMovies();
        return Right(remoteMovies);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      print("ERROR getMovies");
      return Left(EmptyCacheFailure());
    }
  }
}
