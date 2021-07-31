import 'package:flutter/widgets.dart';

class RegisterController extends ChangeNotifier {
  String _email = '';
  String _name = '';
  String _lastname = '';

  void onEmailChanged(String text) {
    this._email = text;
  }

  void onNameChanged(String text) {
    this._name = text;
  }

  void onLastnameChanged(String text) {
    this._lastname = text;
  }

  Future<bool?> submit() async {

    return true;
  }
}
