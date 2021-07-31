import 'package:flutter/material.dart';

import '../widgets/curve_clipper.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../pages/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Theme(
      data: ThemeData(primaryColor: Colors.blue, backgroundColor: Colors.white),
      child: Scaffold(
          body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(children: [
                ClipPath(
                    clipper: CurveClipper(),
                    child: Image(
                        width: _size.width,
                        height: _size.height / 2.5,
                        image: AssetImage(
                            'assets/social_media/login_background.jpg'),
                        fit: BoxFit.cover)),
                SizedBox(height: 20.0),
                Text('FRENDZY',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 10.0)),
                ConstrainedBox(
                    constraints:
                        BoxConstraints(maxWidth: 330.0, minHeight: 200.0),
                    child: Form(
                        child: Column(children: [
                      CustomtextField(
                          hintText: 'Nombre de usuario',
                          labelText: 'Usuario',
                          iconPath: 'assets/social_media/user.svg'),
                      CustomtextField(
                          hintText: '*********',
                          labelText: 'Contraseña',
                          obscureText: true,
                          iconPath: 'assets/social_media/password.svg'),
                      SizedBox(height: 20.0),
                      CustomButton(
                          label: 'Ingresar',
                          onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      HomePage())))
                    ]))),
                SizedBox(height: 20.0),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => HomePage())),
                        child: Container(
                            height: 40.0,
                            alignment: Alignment.center,
                            color: Theme.of(context).primaryColor,
                            child: Text(
                                '¿No tienes una cuenta? Regístrate aquí',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500)))))
              ]))),
    );
  }
}
