import 'package:creditsapp/app/ui/pages/login/utils/send_login_form.dart';
import 'package:flutter/material.dart';

import 'package:flutter_meedu/flutter_meedu.dart';
// import 'package:flutter_meedu/router.dart' as router;

import 'package:creditsapp/app/ui/pages/login/login_page.dart';
import 'package:creditsapp/app/ui/global_widgets/custom_input_field.dart';
import 'package:creditsapp/app/ui/global_widgets/rounded_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);

  final _controller = loginProvider.read;

  @override
  Widget build(BuildContext context) {
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
                                  'assets/images/professor.svg'),
                            ),
                            const SizedBox(height: 20.0),
                            CustomInputField(
                              label: 'Usuario',
                              onChanged: _controller.onUserChanged,
                              validator: (text) {
                                if (text!.trim().length >= 6) {
                                  return null;
                                }
                                return "Usuario inválido";
                              },
                            ),
                            const SizedBox(height: 20.0),
                            CustomInputField(
                              label: 'Contraseña',
                              isPassword: true,
                              onChanged: _controller.onPasswordChanged,
                              validator: (text) {
                                if (text!.trim().length >= 6) {
                                  return null;
                                }
                                return "Contraseña inválida";
                              },
                            ),
                            const SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const SizedBox(width: 10.0),
                                RoundedButton(
                                    text: 'Acceder',
                                    onPressed: () => sendLoginForm(context) ),
                              ],
                            ),
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
