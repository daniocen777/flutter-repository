import 'package:dartz/dartz.dart';
import 'package:rick_morty_clean/core/errors/exceptions.dart';

import 'package:rick_morty_clean/core/network/network_info.dart';
import 'package:rick_morty_clean/features/rick_and_morty/data/datasources/remote_datasource.dart';
import 'package:rick_morty_clean/features/rick_and_morty/domain/entities/result.dart';
import 'package:rick_morty_clean/features/rick_and_morty/domain/entities/characters.dart';
import 'package:rick_morty_clean/core/errors/failures.dart';
import 'package:rick_morty_clean/features/rick_and_morty/domain/repositories/characters_repository.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final RemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  CharactersRepositoryImpl(
      {required this.remoteDatasource, required this.networkInfo});

  @override
  Future<Either<Failure, Character>> getAllCharacters() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCharacters = await remoteDatasource.getAllCharacters();
        return Right(remoteCharacters);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      print('No está conectado');
    }
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Result>> getSingleCharacter(int id) async {
    // TODO: implement getSingleCharacter
    throw UnimplementedError();
  }
}
