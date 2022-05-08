import 'package:creditsapp/app/ui/pages/login/widgets/login_form_widget.dart';
import 'package:creditsapp/app/ui/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter_meedu/flutter_meedu.dart';

import 'package:creditsapp/app/ui/pages/login/controller/login_controller.dart';

final loginProvider = SimpleProvider((_) => LoginController());

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    return ProviderListener<LoginController>(
      provider: loginProvider,
      builder: (_, controller) {
        return Scaffold(
          body: OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              if (width <= 480) {
                return LoginForm();
              }
              return Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(
                        color: primaryDarkColor.withOpacity(0.4),
                      )),
                  Expanded(flex: 2, child: LoginForm())
                ],
              );
            },
          ),
        );
      },
    );
  }
}
