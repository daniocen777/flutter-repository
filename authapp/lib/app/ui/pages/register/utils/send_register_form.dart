import 'package:authapp/app/domain/inputs/sign_up.dart';
import 'package:authapp/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:authapp/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:authapp/app/ui/routes/routes.dart';
import 'package:flutter/widgets.dart';

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
