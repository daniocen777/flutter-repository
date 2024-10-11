import '../../core/util/typedef.dart';
import '../entity/character_entity.dart';

abstract class CharacterRepository {
  ResultFuture<List<CharacterEntity>> getCharacters(
      {int limit = 5, int offset = 0});
}
