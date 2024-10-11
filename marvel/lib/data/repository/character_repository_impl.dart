import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../core/util/typedef.dart';
import '../../domain/entity/character_entity.dart';
import '../../domain/repository/character_repository.dart';
import '../datasource/character_datasource_impl.dart';
import '../mapper/character_mapper.dart';
import '../model/character_model.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  CharacterRepositoryImpl(this._characterDatasource);

  final CharacterDatasource _characterDatasource;

  @override
  ResultFuture<List<CharacterEntity>> getCharacters(
      {int limit = 5, int offset = 0}) async {
    try {
      final result = await _characterDatasource.getCharacters(
          limit: limit, offset: offset);

      final List<CharacterModel>? listCharacters = result!.data!.results;
      if (listCharacters != null && listCharacters.isEmpty) {
        return const Left(
            ServerFailure(message: 'List is empty', statusCode: 404));
      }

      final List<CharacterEntity> characters = listCharacters!
          .map((item) => CharacterMapper.toEntity(item))
          .toList();

      return Right(characters);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
