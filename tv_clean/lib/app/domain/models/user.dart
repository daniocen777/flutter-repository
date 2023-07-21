import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

/* Generar el archivo user.g.dart en la linea de comandos
  $> flutter pub run build_runner build
  => Crear archivo build.yaml y colocar esa configuración que
  al momento de generar el código, tome la carpeta models.
  => En el gitignore, ignorar los archivos .g (*.g.dart)
 */
part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  const User({required this.id, required this.username});

  final int id;
  final String username;

  @override
  List<Object?> get props => [id, username];

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
