import 'package:equatable/equatable.dart';

import 'thumbnail_entity.dart';

class CharacterEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final DateTime modified;
  final ThumbnailEntity thumbnail;

  const CharacterEntity(
      {required this.id,
      required this.name,
      required this.description,
      required this.modified,
      required this.thumbnail});

  @override
  List<Object?> get props => [id, name, description, modified, thumbnail];
}
