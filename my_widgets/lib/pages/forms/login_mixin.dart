import 'package:flutter/material.dart';
import 'package:my_widgets/pages/forms/login_page.dart';

/* 
permite añadirle características específicas a una instancia de clase o a una clase en particular, con el fin de reutilizar información
 */

// Solo se usará un State con LoginFormPage
mixin LoginMixin on State<LoginFormPage> {
  String? emailValidator(String? text) {
    text ??= ''; // text = text ?? ''
    final isValid = RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(text);
    if (isValid) {
      return null;
    }
    return 'Invalid Email';
  }

  String? passwordValidator(String? text) {
    text ??= ''; // text = text ?? ''
    if (text.length >= 8) {
      return null;
    }
    return 'Invalid Password';
  }

  String? checkboxValidaotr(bool? value) {
    if (value == true) {
      return null;
    }
    return 'Checkbox Required';
  }
}
