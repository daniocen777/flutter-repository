import 'package:dartz/dartz.dart';

import 'package:rick_morty_clean/core/errors/failures.dart';
import 'package:rick_morty_clean/features/rick_and_morty/domain/entities/characters.dart';
import 'package:rick_morty_clean/features/rick_and_morty/domain/entities/result.dart';

abstract class CharactersRepository {
  Future<Either<Failure, Character>> getAllCharacters();

  Future<Either<Failure, Character>> getAllCharactersPaginated(int page);

  Future<Either<Failure, Result>> getSingleCharacter(int id);
}
