import 'package:dartz/dartz.dart';

import 'package:rick_morty_clean/core/errors/failures.dart';
import 'package:rick_morty_clean/features/rick_and_morty/domain/entities/result.dart';
import 'package:rick_morty_clean/features/rick_and_morty/domain/repositories/characters_repository.dart';

class GetSingleCharacter {
  final CharactersRepository repository;

  GetSingleCharacter(this.repository);

  Future<Either<Failure, Result>> call(int id) async {
    return repository.getSingleCharacter(id);
  }
}
