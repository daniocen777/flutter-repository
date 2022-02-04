import 'package:authapp/app/domain/inputs/sign_up.dart';
import 'package:authapp/app/domain/response/sign_up_response.dart';

abstract class SignUpRepository {
  Future<SignUpResponse> register(SignUpData data);
}
