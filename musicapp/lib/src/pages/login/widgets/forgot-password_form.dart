import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:musicapp/src/libs/auth.dart';

import 'package:musicapp/src/pages/login/widgets/input_text.dart';
import 'package:musicapp/src/utils/app_colors.dart';
import 'package:musicapp/src/utils/extras.dart';
import 'package:musicapp/src/utils/responsive.dart';
import 'package:musicapp/src/widgets/rounded_button.dart';

class ForgotPasswordForm extends StatefulWidget {
  final Alignment alignment;

  const ForgotPasswordForm({Key key, this.alignment = Alignment.bottomCenter})
      : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  bool _sent = false;
  final GlobalKey<InputTextState> _emailKey = GlobalKey<InputTextState>();

  Future<void> _submit() async {
    final String email = _emailKey.currentState.value;

    final bool emailOk = _emailKey.currentState.isOk;

    if (emailOk) {
      final bool isOk =
          await Auth.instance.sendResetEmailLink(context, email: email);
      setState(() {
        _sent = isOk;
      });
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
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          constraints: BoxConstraints(maxWidth: 400.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Reset Password',
                  style: TextStyle(
                      fontSize: 22.0,
                      color: AppColors.primary,
                      fontFamily: 'raleway',
                      fontWeight: FontWeight.bold)),
              Text('Aquí podrá cambiar su contraseña, si lo ha olvidado',
                  style: TextStyle(
                      color: AppColors.primary, fontWeight: FontWeight.w300)),
              SizedBox(height: responsive.ip(2.0)),
              _sent
                  ? Text('The email to reset your password was sent')
                  : InputText(
                      key: _emailKey,
                      keyboardType: TextInputType.emailAddress,
                      iconPath: 'assets/pages/login/icons/mail.svg',
                      placeholder: 'Email Address',
                      validator: (text) => Extras.isValidEmail(text),
                    ),
              SizedBox(height: responsive.ip(2.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('← Back to Login')),
                  (!_sent) ? SizedBox(width: 10.0) : Container(),
                  (!_sent)
                      ? RoundedButton(
                          label: 'Send',
                          onPressed: this._submit,
                        )
                      : Container(),
                ],
              ),
              SizedBox(height: responsive.ip(3.0)),
            ],
          ),
        ),
      ),
    );
  }
}
