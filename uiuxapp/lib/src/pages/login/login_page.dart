import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:uiuxapp/src/pages/login/login_controller.dart';

import '../../utils/font_style.dart';
import '../../utils/responsive.dart';
import 'widgets/login_form.dart';
import 'widgets/social_login.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive _responsive = Responsive.of(context);
    return ChangeNotifierProvider<LoginController>(
        create: (BuildContext context) => LoginController(),
        builder: (context, __) {
          return Scaffold(
            body: SafeArea(
                /* GestureDetector => para salir del teclado con un tap (ios) | necesita color (transparent) */
                child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 10.0),
                      Text(
                        'Bienvenid@ de vuelta',
                        style: FontStyle.title.copyWith(fontSize: 22.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: SvgPicture.asset(
                          'assets/pages/login/login.svg',
                          width: _responsive.ip(50.0),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      /* Correo */
                      LoginForm(),                      
                      SocialLogin(),
                    ],
                  ),
                ),
              ),
            )),
          );
        });
  }
}
