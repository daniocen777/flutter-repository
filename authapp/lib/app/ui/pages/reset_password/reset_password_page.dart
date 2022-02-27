import 'package:authapp/app/ui/global_widgets/rounded_button.dart';
import 'package:flutter/material.dart';

import 'package:flutter_meedu/flutter_meedu.dart';

import 'package:authapp/app/domain/response/reset_password_response.dart';
import 'package:authapp/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:authapp/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:authapp/app/ui/pages/reset_password/controller/reset_password_controller.dart';
import 'package:authapp/app/utils/email_validator.dart';
import 'package:authapp/app/ui/global_widgets/custom_input_field.dart';
import 'package:flutter_svg/svg.dart';

final resetPasswordProvider = SimpleProvider(
  (_) => ResetPasswordController(),
);

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isThemeDark = context.isDarkMode;
    final padding = context.mediaQueryPadding;
    final height = context.height - padding.top - padding.bottom;

    return ProviderListener<ResetPasswordController>(
      provider: resetPasswordProvider,
      builder: (_, controller) {
        return Scaffold(
          appBar: AppBar(),
          body: ListView(
            children: [
              SizedBox(
                height: height,
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Container(
                    width: double.infinity,
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(15.0),
                    child: Align(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 360.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: SvgPicture.asset(
                                  'assets/images/${isThemeDark ? "dark" : "light"}/password.svg'),
                            ),
                            const Text('Ingrese un correo electrónico'),
                            CustomInputField(
                              label: 'Correo',
                              onChanged: controller.onEmailChanged,
                              inputType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 20.0),
                            SizedBox(
                              width: double.infinity,
                              child: RoundedButton(
                                  onPressed: () => _submit(context),
                                  text: 'Enviar'),
                            ),
                            const SizedBox(height: 30.0)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _submit(BuildContext context) async {
    final controller = resetPasswordProvider.read;
    if (isValidEmail(controller.email)) {
      ProgressDialog.show(context); // progreso
      final response = await controller.submit();
      if (response == ResetPasswordResponse.ok) {
        Dialogs.alert(context,
            title: 'Correcto',
            content: 'Se ha enviado un correo a ${controller.email}');
      } else {
        String error = '';
        switch (response) {
          case ResetPasswordResponse.userDisabled:
            error = 'Usuario inhabilitado';
            break;
          case ResetPasswordResponse.userNotFound:
            error = 'Usuario no encontrado';
            break;
          case ResetPasswordResponse.networkRequestFailed:
            error = 'Error de conexión';
            break;
          case ResetPasswordResponse.tooManyRequests:
            error = 'Muchas peticiones';
            break;
          default:
            error = 'Error inesperado';
        }
        Dialogs.alert(context, title: 'Error', content: error);
      }
      Navigator.pop(context); // minimizar dialog
    } else {
      Dialogs.alert(context, title: 'Error', content: 'Correo inválido');
    }
  }
}
