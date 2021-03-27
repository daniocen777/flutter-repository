import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ydchat/presentation/screens/registration_screen.dart';

import 'package:ydchat/presentation/utils/responsive.dart';
import 'package:ydchat/presentation/widgets/theme/theme.dart';

class WelcomeScreen extends StatelessWidget {
  static final String route = 'welcome';

  @override
  Widget build(BuildContext context) {
    final Responsive _responsive = new Responsive.of(context);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text('Bienvenid@ al chat personal',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: _responsive.ip(3.5),
                      fontWeight: FontWeight.w600)),
            ),
            SvgPicture.asset('assets/chat.svg',
                width: _responsive.wp(60.0), height: _responsive.hp(65.0)),
            Column(
              children: [
                Text('Este chat sólo lo usarán los elegidos',
                    style: TextStyle(
                      fontSize: _responsive.ip(2.5),
                    )),
                SizedBox(
                  height: 20.0,
                ),
                MaterialButton(
                  color: primaryColorDark,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Text('Continuar',
                      style: TextStyle(color: Colors.white, fontSize: 18.0)),
                  onPressed: () {
                     Navigator.pushNamed(context, RegistrationScreen.route);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
