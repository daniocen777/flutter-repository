// Estado del controlador
/* Generar el archivo sign_in_state.freezed.dart en la linea de comandos
  => Eliminar cache para evitar conflictos (Ver carpeta .vscode/settings)
  $> flutter pub run build_runner build --delete-conflicting-outputs
  $> flutter pub run build_runner build
  => Instalar extensión Command Runner
  => En build.yaml, colocar la nueva configuración
  ==> En el .gitignore *.freezed.dart
 */
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  factory SignInState({
    @Default('')  String username, 
    @Default('')  String password, 
    @Default(false) bool fetching
    }) = _SignInState;
}


