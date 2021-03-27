import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ydchat/presentation/bloc/phone_auth/phone_auth_cubit.dart';

import 'package:ydchat/presentation/widgets/theme/theme.dart';

class PhoneVerificationPage extends StatefulWidget {
  static final String route = 'verification';
  final String? phoneNumber;

  const PhoneVerificationPage({Key? key, this.phoneNumber}) : super(key: key);

  @override
  _PhoneVerificationPageState createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  String get _phoneNumber => widget.phoneNumber!;

  TextEditingController _pinCodeController = TextEditingController();

  /* @override
  void dispose() {
    _pinCodeController.dispose();
    super.dispose();
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Verifica tu número de celular',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: primaryColor,
                        fontWeight: FontWeight.w500)),
                FaIcon(FontAwesomeIcons.ellipsisV),
              ],
            ),
            _pinCodeWidger(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  color: primaryColorDark,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Text('Verificar',
                      style: TextStyle(color: Colors.white, fontSize: 18.0)),
                  onPressed: this._submitSmsPinCode,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _pinCodeWidger() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PinCodeTextField(
              controller: _pinCodeController,
              keyboardType: TextInputType.number,
              length: 6,
              appContext: context,
              backgroundColor: Colors.transparent,
              obscureText: true,
              onChanged: (String value) {
                print(value);
              }),
          Text('Ingresa el código de verificación')
        ],
      ),
    );
  }

  void _submitSmsPinCode() {
    if (_pinCodeController.text.isNotEmpty) {
      BlocProvider.of<PhoneAuthCubit>(context)
          .submitSmsCode(_pinCodeController.text);
    }
  }
}
