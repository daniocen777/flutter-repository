/* Valores inmutables => freezed */
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_state.freezed.dart';

/* Para generar el archivo freezed, ejecutar el comando:
flutter pub run build_runner build => Creará un archivo *.freezed.dart*/

@freezed
class RegisterState with _$RegisterState {
  factory RegisterState(
      {@Default('') String email,
      @Default('') String password,
      @Default('') String verifyPassword,
      @Default('') String name,
      @Default('') String lastname,
      @Default(false) bool termnsOk}) = _RegisterState;

  static RegisterState get initialState => RegisterState();
}
