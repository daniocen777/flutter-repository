import 'package:authapp/app/ui/pages/login/widgets/social_buttons.dart';
import 'package:flutter/material.dart';

import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:flutter_svg/flutter_svg.dart';

import 'package:authapp/app/ui/pages/login/login_page.dart';
import 'package:authapp/app/ui/pages/login/utils/send_login_form.dart';
import 'package:authapp/app/utils/email_validator.dart';
import 'package:authapp/app/ui/global_widgets/custom_input_field.dart';
import 'package:authapp/app/ui/global_widgets/rounded_button.dart';
import 'package:authapp/app/ui/routes/routes.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);
  final _controller = loginProvider.read;

  @override
  Widget build(BuildContext context) {
    final isThemeDark = context.isDarkMode;
    final padding = context.mediaQueryPadding;
    final height = context.height - padding.top - padding.bottom;

    return ListView(
      children: [
        SizedBox(
          height: height,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: ListView(
              children: [
                Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  padding: const EdgeInsets.all(15.0),
                  child: Align(
                    child: Form(
                      key: _controller.formKey,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 360.0),
                        child: Column(
                          mainAxisAlignment: context.isTablet
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.end,
                          children: [
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: SvgPicture.asset(
                                  'assets/images/${isThemeDark ? "dark" : "light"}/welcome.svg'),
                            ),
                            const SizedBox(height: 20.0),
                            CustomInputField(
                              label: 'Correo',
                              onChanged: _controller.onEmailChanged,
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
                              onChanged: _controller.onPasswordChanged,
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
                                    child:
                                        const Text('¿Olvidó su contraseña?')),
                                const SizedBox(width: 10.0),
                                RoundedButton(
                                    text: 'Acceder',
                                    onPressed: () => sendLoginForm(context)),
                                const SizedBox(width: 20.0),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('¿No tienes una cuenta?'),
                                TextButton(
                                    onPressed: () =>
                                        router.pushNamed(Routes.register),
                                    child: const Text(
                                      'Crear Cuenta',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            const Text('O ingresa con:'),
                            const SocialButtons(),
                            if (!context.isTablet) const SizedBox(height: 20.0)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
