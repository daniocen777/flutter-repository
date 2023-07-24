import 'package:freezed_annotation/freezed_annotation.dart';

/* Generar el archivo user.g.dart en la linea de comandos
  $> flutter pub run build_runner build
  => Crear archivo build.yaml y colocar esa configuración que
  al momento de generar el código, tome la carpeta models.
  => Instalar extensión Command Runner
  => En el gitignore, ignorar los archivos .g (*.g.dart)
  => en alalysis_options.yaml, colocar analyzer.errors... 
 */
part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  // Definir constructor si clase tiene funciones personzalizadas (getFormatted)
  const User._();

  // Constructor para el freezed
  const factory User({
    required int id,
    required String username,

    ///
    @JsonKey(
      name: 'avatar',
      fromJson: avatarPathFromJson,
    )
        String? avatarPath,
  }) = _User;

  // Como el toString
  String getFormatted() {
    return '$username $id';
  }

  // No es neceario toJson, freezed lo hace, solo necesita el fromJson
  // Map<String, dynamic> toJson() => _$UserToJson(this);
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

// Función global
String? avatarPathFromJson(Map<String, dynamic> json) {
  return json['tmdb']?['avatar_path'] as String?;
}
