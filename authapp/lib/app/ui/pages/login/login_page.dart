import 'package:authapp/app/ui/global_controllers/session_controller.dart';
import 'package:authapp/app/ui/pages/login/utils/send_login_form.dart';
import 'package:authapp/app/utils/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/router.dart' as router;

import 'package:authapp/app/ui/global_widgets/custom_input_field.dart';
import 'package:authapp/app/ui/pages/login/controller/login_controller.dart';
import 'package:authapp/app/ui/routes/routes.dart';

/* Estado */

final loginProvider = SimpleProvider(
  (_) => LoginController(sessionProvider.read),
);

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<LoginController>(
      provider: loginProvider,
      builder: (_, controller) {
        return Scaffold(
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomInputField(
                        label: 'Correo',
                        onChanged: controller.onEmailChanged,
                        inputType: TextInputType.emailAddress,
                        validator: (text) {
                          if (isValidEmail(text!)) {
                            return null;
                          }
                          return "Correo inválido";
                        },
                      ),
                      const SizedBox(height: 20.0),
                      CustomInputField(
                        label: 'Contraseña',
                        onChanged: controller.onPasswordChanged,
                        isPassword: true,
                        validator: (text) {
                          if (text!.trim().length >= 6) {
                            return null;
                          }
                          return "Contraseña inválida";
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () =>
                                  router.pushNamed(Routes.resetPassword),
                              child: const Text('¿Olvidó su contraseña?')),
                          ElevatedButton(
                              onPressed: () => sendLoginForm(context),
                              child: const Text('Acceder')),
                          const SizedBox(width: 20.0),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                          onPressed: () => router.pushNamed(Routes.register),
                          child: const Text('Crear Cuenta')),
                      const SizedBox(height: 30.0)
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
