import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:uiuxapp/src/routes/routes.dart';
import 'package:uiuxapp/src/utils/responsive.dart';

import '../../global_widgets/circle_button.dart';
import '../../global_widgets/rounded_button.dart';
import '../../utils/font_style.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive _responsive = Responsive.of(context);
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: SvgPicture.asset(
                  'assets/pages/welcome/mobil.svg',
                  width: _responsive.ip(50.0),
                ),
              ),
              Text('Bienvenid@', style: FontStyle.title),
              SizedBox(height: 20.0),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.0),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 270.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: RoundedButton(
                        label: 'login',
                        onPressed: () => Navigator.pushReplacementNamed(
                            context, Routes.LOGIN),
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: RoundedButton(
                        label: 'Registro',
                        textColor: Colors.black87,
                        backgroundColor: Colors.white,
                        borderColor: Colors.black87,
                        onPressed: () => print('LOGIN'),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 40.0),
              Text('O, ingresa con:'),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleButton(
                    iconPath: 'assets/pages/welcome/facebook.svg',
                    backgroundColor: Colors.blueAccent,
                    onPressed: () => print('Facebook'),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  CircleButton(
                    iconPath: 'assets/pages/welcome/google.svg',
                    backgroundColor: Colors.redAccent,
                    onPressed: () => print('Facebook'),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  CircleButton(
                    iconPath: 'assets/pages/welcome/apple.svg',
                    backgroundColor: Colors.grey,
                    onPressed: () => print('Facebook'),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      )),
    );
  }
}
