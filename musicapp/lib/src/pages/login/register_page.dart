import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:musicapp/src/pages/login/widgets/register_form.dart';
import 'package:musicapp/src/pages/login/widgets/welcome.dart';
import 'package:musicapp/src/utils/responsive.dart';

import 'package:after_layout/after_layout.dart';

class RegisterPage extends StatefulWidget {
  static final routeName = 'register';

  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with AfterLayoutMixin {
  @override
  void initState() {
    super.initState();
    /* Tema oscuro del notch */
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // Valor mínimo del ancho o alto
    final bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    /* Smartphone => Bloquear orientación landscape*/
    if (!isTablet) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Scaffold(
        body: SafeArea(
      child: GestureDetector(
          onTap: () {
            /* No minimizar el teclado */
            FocusScope.of(context).unfocus();
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                if (responsive.width <= 700) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: <Widget>[
                                Welcome(
                                  isLogin: false,
                                ),
                                RegisterForm(
                                  alignment: Alignment.center,
                                ),
                              ],
                            ),
                          ),
                        )
                      ]);
                } else {
                  return Row(
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: Container(
                                height: responsive.height,
                                padding: EdgeInsets.only(left: 20.0),
                                child: Center(child: Welcome()))),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Container(
                                height: responsive.height,
                                child: Center(child: RegisterForm()))),
                      )
                    ],
                  );
                }
              },
            ),
          )),
    ));
  }
}
