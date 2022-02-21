import 'package:flutter/material.dart';

import 'package:flutter_meedu/flutter_meedu.dart';

import 'package:authapp/app/ui/utils/colors.dart';
import 'package:authapp/app/utils/responsive.dart';
import 'package:authapp/app/ui/pages/login/widgets/login_form.dart';
import 'package:authapp/app/ui/global_controllers/session_controller.dart';
import 'package:authapp/app/ui/pages/login/controller/login_controller.dart';

final loginProvider = SimpleProvider(
  (_) => LoginController(sessionProvider.read),
);

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive _responsive = Responsive.of(context);
    return ProviderListener<LoginController>(
      provider: loginProvider,
      builder: (_, controller) {
        return Scaffold(body: OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
          if (_responsive.width <= 450) {
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
        }));
      },
    );
  }
}
