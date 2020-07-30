import 'package:cupertinoapp/src/blocs/master/master_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:cupertinoapp/src/pages/login_page.dart';
import 'package:cupertinoapp/src/utils/dialogs.dart';
import 'package:cupertinoapp/src/widgets/avatar_widget.dart';
import 'package:cupertinoapp/src/widgets/left-right-button-icon_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:websafe_svg/websafe_svg.dart';

import 'package:cupertinoapp/src/blocs/master/master_bloc.dart';

class MoreTabPage extends StatelessWidget {
  _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    // Remueve todas las páginas anteriores
    Navigator.pushNamedAndRemoveUntil(
        context, LoginPage.routename, (_) => false);
  }

  _confirm(BuildContext context, MasterBloc masterBloc) async {
    final bool isOk = await Dialogs.cupertinoConfirm(
      context,
      title: 'Acción Requerida',
      body: '¿Desea salir de la aplicación?',
    );

    if (isOk) {
      masterBloc.add(MasterLogOut());
      _logout(context);
    }
  }

  _setEmail(BuildContext context) {
    Dialogs.inputEmail(context,
        label: 'Ingrese su email',
        placeholder: 'example@mail.com', onOk: (String text) {
      print(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MasterBloc>(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 30.0),
              color: Color(0xfff8f8f8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Avatar(),
                  SizedBox(height: 20.0),
                  Text('Bienvenido'),
                  Text('danicode',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 120.0,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      width: 100.0,
                      height: 100.0,
                      margin: EdgeInsets.all(5.0),
                      color: Colors.black12);
                },
              ),
            ),
            LeftRifgtIconButton(
              leftIcon: 'assets/icons/mail.svg',
              rightContent: Text('danicode@mai..com',
                  style: TextStyle(color: Color(0xffaaaaaa))),
              label: 'Email',
              onPressed: () => _setEmail(context),
            ),
            LeftRifgtIconButton(
              leftIcon: 'assets/icons/shield.svg',
              rightContent:
                  WebsafeSvg.asset('assets/icons/next.svg', width: 20.0),
              label: 'Configurciones de privacidad',
              onPressed: () => print('Configurciones de privacidad'),
            ),
            LeftRifgtIconButton(
              leftIcon: 'assets/icons/bell.svg',
              rightContent:
                  Text('Activado', style: TextStyle(color: Color(0xffaaaaaa))),
              label: 'Notificaciones push',
              onPressed: () => print('Notificaciones push'),
            ),
            LeftRifgtIconButton(
              leftIcon: 'assets/icons/logout.svg',
              label: 'Cerrar Sesión ',
              onPressed: () => _confirm(context, bloc),
            )
          ],
        ),
      ),
    );
  }
}
