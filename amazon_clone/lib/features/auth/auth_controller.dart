import 'package:flutter/widgets.dart' show GlobalKey, FormState;

class AuthController {
  String _email = '';
  String _password = '';
  final GlobalKey<FormState> formKey = GlobalKey();

  AuthController();

  void onEmailChanged(String text) {
    _email = text;
  }

  void onPasswordChanged(String text) {
    _password = text;
  }
}
