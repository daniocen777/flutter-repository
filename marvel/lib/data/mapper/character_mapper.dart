import '../../domain/entity/character_entity.dart';
import '../../domain/entity/thumbnail_entity.dart';
import '../model/character_model.dart';

class CharacterMapper {
  static CharacterEntity toEntity(
          CharacterModel characterModel) =>
      CharacterEntity(
          id: characterModel.id!,
          name: characterModel.name!,
          description: characterModel.description ?? 'no-description',
          modified: DateTime.parse(
              characterModel.modified ?? DateTime.now().toString()),
          thumbnail: characterModel.thumbnail as ThumbnailEntity);
}
