import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart' show required;

abstract class LoginEvents {}

class LoginByPassword extends LoginEvents {
  final BuildContext context;
  final String email;
  final String password;

  LoginByPassword(
      {@required this.context, @required this.email, @required this.password});
}

class LoginByFacebook extends LoginEvents {}

class LoginByGoogle extends LoginEvents {}
