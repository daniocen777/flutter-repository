import 'package:authapp/app/domain/repositories/authentication_repository.dart';
import 'package:authapp/app/domain/response/reset_password_response.dart';
import 'package:flutter_meedu/meedu.dart';

class ResetPasswordController extends SimpleNotifier {
  final _authenticationRepository = Get.i.find<AuthenticationRepository>();
  String _email = '';

  String get email => _email;

  void onEmailChanged(String text) {
    _email = text;
  }

  Future<ResetPasswordResponse> submit() {
    return _authenticationRepository.sendResetPasswordLink(_email);
  }
}
