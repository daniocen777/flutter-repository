import 'package:flutter/widgets.dart';

import 'package:flutter_meedu/router.dart' as router;

import 'package:creditsapp/app/ui/global_widgets/dialogs/dialog.dart';
import 'package:creditsapp/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:creditsapp/app/ui/routes/routes.dart';
import 'package:creditsapp/app/ui/pages/login/login_page.dart'
    show loginProvider;

Future<void> sendLoginForm(BuildContext context) async {
  // Recuperar controlador
  final loginController = loginProvider.read;
  final isValidForm = loginController.formKey.currentState!.validate();
  if (isValidForm) {
    ProgressDialog.show(context);
    final signInResponse = await loginController.submit();
    router.pop(); // minimizar dialog
    if (!signInResponse) {
      Dialogs.alert(context, title: 'Error', content: 'No tiene autorización');
    } else {
      router.pushReplacementNamed(Routes.home);
    }
  }
}
