import 'package:flutter/widgets.dart';

import 'package:authapp/app/domain/response/sign_up_response.dart';
import 'package:authapp/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:authapp/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:authapp/app/ui/routes/routes.dart';

import 'package:flutter_meedu/router.dart' as router;

import '../register_page.dart' show registerProvider;

Future<void> sendRegisterForm(BuildContext context) async {
  final registerController = registerProvider.read;
  final isValidForm = registerController.formKey.currentState!.validate();
  if (isValidForm) {
    ProgressDialog.show(context);
    final signUpResponse = await registerController.submit();
    router.pop(); // Cerrar dialg
    if (signUpResponse.error != null) {
      late String content;
      switch (signUpResponse.error) {
        case SignUpError.emailAlreadyInUse:
          content = "El correo ya está siendo utilizado";
          break;
        case SignUpError.weakPassword:
          content = "Error de validación de contraseña";
          break;
        case SignUpError.networkRequestFailed:
          content = "Error de conexión";
          break;
        case SignUpError.tooManyRequests:
          content = "Muchas peticiones a la vez";
          break;
        default:
          content = "Error inesperado";
      }
      Dialogs.alert(context, title: "Error", content: content);
    } else {
      router.pushNamedAndRemoveUntil(Routes.home);
    }
  } else {
    Dialogs.alert(context, title: 'Error', content: 'Formulario inválido');
  }
}
