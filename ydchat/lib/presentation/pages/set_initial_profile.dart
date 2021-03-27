import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ydchat/presentation/bloc/phone_auth/phone_auth_cubit.dart';

import 'package:ydchat/presentation/widgets/theme/theme.dart';

class SetInitialProfilePage extends StatefulWidget {
  static final String route = 'profile';
  final String? phoneNumber;

  const SetInitialProfilePage({Key? key, this.phoneNumber}) : super(key: key);

  @override
  _SetInitialProfilePageState createState() => _SetInitialProfilePageState();
}

class _SetInitialProfilePageState extends State<SetInitialProfilePage> {
  String get _phoneNumber => widget.phoneNumber!;
  TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Column(children: [
              Text('Información de Perfil',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: primaryColor,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: 20.0),
              Text('Ingresa tu nombre y foto de perfil (la foto es opcional)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                  )),
              _rowWidget(),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: MaterialButton(
                    color: primaryColorDark,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Text('Verificar',
                        style: TextStyle(color: Colors.white, fontSize: 18.0)),
                    onPressed: this._submitProfileInfo,
                  ),
                ),
              )
            ])));
  }

  Widget _rowWidget() {
    return Container(
      child: Row(
        children: [
          Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
                color: primaryColorLight,
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            child: Center(
                child: FaIcon(FontAwesomeIcons.camera, color: Colors.white)),
          ),
          SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Ingresa tu nombre'),
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          Container(
            width: 35.0,
            height: 35.0,
            decoration: BoxDecoration(
                color: primaryColorLight,
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            child: Center(
                child: FaIcon(FontAwesomeIcons.smile, color: Colors.white)),
          )
        ],
      ),
    );
  }

  void _submitProfileInfo() {
    if (_nameController.text.isNotEmpty) {
      BlocProvider.of<PhoneAuthCubit>(context).submitProfileInfo(
          name: _nameController.text,
          profileUrl: '',
          phoneNumber: _phoneNumber);
    }
  }
}
