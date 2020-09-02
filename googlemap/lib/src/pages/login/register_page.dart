import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googlemap/src/pages/login/widgets/avatar_button.dart';
import 'package:googlemap/src/pages/login/widgets/circle.dart';
import 'package:googlemap/src/pages/login/widgets/register_form.dart';
import 'package:googlemap/src/utils/responsive.dart';

class RegisterPage extends StatefulWidget {
  static final String route = 'register';

  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                        top: pinkSize * 0.22,
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Hello\n Sign Up to get started ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: responsive.dp(1.6),
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: responsive.dp(4.5),
                            ),
                            AvatarButton(
                              imageSize: responsive.wp(25),
                            )
                          ],
                        )),
                    RegisterForm(),
                    Positioned(
                        left: 15.0,
                        top: pinkSize * 0.07,
                        child: SafeArea(
                          child: CupertinoButton(
                              padding: EdgeInsets.all(10.0),
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(30.0),
                              child: Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        )),
                  ],
                ),
              ))),
    );
  }
}
