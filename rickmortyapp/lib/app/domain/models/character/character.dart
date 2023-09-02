import 'package:freezed_annotation/freezed_annotation.dart';

import '../location/location.dart';
import '../origin/origin.dart';

part 'character.freezed.dart';
part 'character.g.dart';

enum Status {
  @JsonValue('Alive')
  alive,
  @JsonValue('Dead')
  dead,
  @JsonValue('unknown')
  unknown,
}

enum Gender {
  @JsonValue('Female')
  female,
  @JsonValue('Male')
  male,
  @JsonValue('Genderless')
  genderless,
  @JsonValue('unknown')
  unknown,
}

@freezed
class Character with _$Character {
  factory Character({
    required int id,
    required String name,
    required Status status,
    required String species,
    String? type,
    required Gender gender,
    required Origin origin,
    required Location location,
    required String image,
    required List<String> episode,
    required String url,
    required DateTime created,
  }) = _Character;

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
}
