import 'package:authapp/app/domain/response/sign_in_response.dart';
import 'package:authapp/app/ui/routes/routes.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_meedu/router.dart' as router;

import 'package:authapp/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:authapp/app/ui/global_widgets/dialogs/progress_dialog.dart';

import 'package:authapp/app/ui/pages/login/login_page.dart' show loginProvider;

Future<void> sendLoginForm(BuildContext context) async {
  // Recuperar controlador
  final loginController = loginProvider.read;
  final isValidForm = loginController.formKey.currentState!.validate();
  if (isValidForm) {
    ProgressDialog.show(context);
    final signInResponse = await loginController.submit();
    router.pop(); // minimizar dialog
    if (signInResponse.error != null) {
      late String errorMessage;
      switch (signInResponse.error) {
        case SignInError.userNotFound:
          errorMessage = 'Usuario no encontrado';
          break;
        case SignInError.networkRequestFailed:
          errorMessage = 'Fallo al conectarse a internet';
          break;
        case SignInError.userDisabled:
          errorMessage = 'Usuario desabilitado';
          break;
        case SignInError.wrongPassword:
          errorMessage = 'Contraseña incorrecta';
          break;
        case SignInError.unknown:
          errorMessage = 'Error no identificado';
          break;
        default:
          errorMessage = 'Error desconocido';
          break;
      }
      Dialogs.alert(context, title: 'Error', content: errorMessage);
    } else {
      router.pushReplacementNamed(Routes.home);
    }
  }
}
