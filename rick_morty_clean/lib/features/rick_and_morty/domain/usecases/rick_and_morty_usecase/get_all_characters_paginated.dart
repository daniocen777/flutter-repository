import 'package:dartz/dartz.dart';

import 'package:rick_morty_clean/core/errors/failures.dart';
import 'package:rick_morty_clean/features/rick_and_morty/domain/entities/characters.dart';
import 'package:rick_morty_clean/features/rick_and_morty/domain/repositories/characters_repository.dart';

class GetAllCharactersPaginatedUseCase {
  final CharactersRepository repository;

  GetAllCharactersPaginatedUseCase(this.repository);

  Future<Either<Failure, Character>> call(int page) async {
    return await repository.getAllCharactersPaginated(page);
  }
}