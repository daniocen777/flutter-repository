import 'package:flutter/material.dart';
import 'package:googlemap/src/pages/login/widgets/circle.dart';
import 'package:googlemap/src/pages/login/widgets/icon_container.dart';
import 'package:googlemap/src/pages/login/widgets/login_form.dart';
import 'package:googlemap/src/utils/responsive.dart';

class LoginPage extends StatefulWidget {
  static final String route = 'login';

  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final double pinkSize = responsive.wp(88.0);
    final double orangeSize = responsive.wp(57.0);

    return Scaffold(
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // Minimiza teclado
          },
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                width: double.infinity,
                height: responsive.height,
                color: Colors.white,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                      top: -pinkSize * 0.3,
                      right: -pinkSize * 0.2,
                      child: Circle(
                        size: pinkSize,
                        colors: <Color>[
                          Colors.pinkAccent,
                          Colors.pink,
                        ],
                      ),
                    ),
                    Positioned(
                      top: -orangeSize * 0.35,
                      left: -orangeSize * 0.15,
                      child: Circle(
                        size: orangeSize,
                        colors: <Color>[
                          Colors.orange,
                          Colors.deepOrangeAccent,
                        ],
                      ),
                    ),
                    Positioned(
                        top: pinkSize * 0.35,
                        child: Column(
                          children: <Widget>[
                            IconContainer(
                              size: responsive.wp(17),
                            ),
                            SizedBox(
                              height: responsive.dp(3.0),
                            ),
                            Text(
                              'Hello Again\nWelcome Back',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: responsive.dp(1.6)),
                            )
                          ],
                        )),
                        SizedBox(
                          height: responsive.hp(15.0),
                        ),
                    LoginForm()
                  ],
                ),
              ))),
    );
  }
}
