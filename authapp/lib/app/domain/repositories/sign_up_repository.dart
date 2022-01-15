import 'package:authapp/app/domain/inputs/sign_up.dart';

abstract class SignUpRepository {
  Future<SignUpResponse> register(SignUpData data);
}
