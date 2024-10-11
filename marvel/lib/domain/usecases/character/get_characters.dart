import 'package:equatable/equatable.dart';

import '../../../core/usecase/usecase.dart';
import '../../../core/util/typedef.dart';
import '../../entity/character_entity.dart';
import '../../repository/character_repository.dart';

class GetCharacters
    extends UseCaseWithParams<List<CharacterEntity>, GetCharactersParams> {
  GetCharacters(this._characterRepository);

  final CharacterRepository _characterRepository;

  @override
  ResultFuture<List<CharacterEntity>> call(GetCharactersParams params) async =>
      _characterRepository.getCharacters(
          limit: params.limit, offset: params.offset);
}

class GetCharactersParams extends Equatable {
  const GetCharactersParams({required this.limit, required this.offset});

  const GetCharactersParams.empty() : this(limit: 5, offset: 0);

  final int limit;
  final int offset;

  @override
  List<Object?> get props => [limit, offset];
}
