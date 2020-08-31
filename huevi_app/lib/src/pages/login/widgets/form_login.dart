import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huevi_app/src/pages/home/home_page.dart';
import 'package:huevi_app/src/pages/login/widgets/input_text.dart';
import 'package:huevi_app/src/utils/extras.dart';
import 'package:huevi_app/src/utils/responsive.dart';
import 'package:huevi_app/src/widgets/circle_button.dart';
import 'package:huevi_app/src/widgets/rounded_button.dart';

class LoginForm extends StatefulWidget {
  final Alignment alignment;
  LoginForm({Key key, this.alignment = Alignment.bottomCenter})
      : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<InputTextState> _emailKey = GlobalKey<InputTextState>();
  final GlobalKey<InputTextState> _passwordKey = GlobalKey<InputTextState>();

  Future<void> _submit() async {
    final String email = _emailKey.currentState.value;
    final String password = _passwordKey.currentState.value;
    final bool emailOk = _emailKey.currentState.isOk;
    final bool passwordOk = _passwordKey.currentState.isOk;
    if (emailOk && passwordOk) {
      print('correo: $email');
      print('Contraseña: $password');
      Navigator.pushReplacementNamed(context, HomePage.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Align(
      alignment: widget.alignment,
      child: SafeArea(
        top: false,
        child: Container(
          width: 330.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InputText(
                key: _emailKey,
                keyboardType: TextInputType.emailAddress,
                iconPath: 'assets/icons/mail.svg',
                placeholder: 'Pon tu correo',
                validator: (text) => Extras.isValidEmail(text),
              ),
              SizedBox(height: responsive.ip(2.0)),
              InputText(
                  key: _passwordKey,
                  obscureText: true,
                  iconPath: 'assets/icons/key.svg',
                  placeholder: 'Contraseña',
                  validator: (text) {
                    return text.trim().length >= 6;
                  }),
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text('¿Olvidaste tu contraseña?, huevón eres.',
                      style: TextStyle(fontFamily: 'sans')),
                  onPressed: () {},
                ),
              ),
              SizedBox(height: responsive.ip(2.0)),
              RoundedButton(
                label: 'Ingresar',
                onPressed: this._submit,
              ),
              SizedBox(height: responsive.ip(3.3)),
              Text('O ingresa con:'),
              SizedBox(height: responsive.ip(1.5)),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    /* Auth facebook */
                    CircleButton(
                      backgroundColor: Color(0xff448AFF),
                      size: 55.0,
                      iconPath: 'assets/icons/facebook.svg',
                      onPressed: () {},
                    ),
                    SizedBox(width: 20.0),
                    /* Auth Google */
                    CircleButton(
                      size: 55.0,
                      backgroundColor: Color(0xffFF1744),
                      iconPath: 'assets/icons/ui.svg',
                      onPressed: () {
                        print('GOOGLE');
                      },
                    )
                  ]),
              SizedBox(height: responsive.ip(2.0)),
            ],
          ),
        ),
      ),
    );
  }
}
