/* Pedirá el permiso para acceder a la ubicación del dispositivo */
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:permission_handler/permission_handler.dart';

import 'package:mapapp/src/pages/home_page.dart';

class RequestPersmissionPage extends StatefulWidget {
  static final route = 'request-permission';
  RequestPersmissionPage({Key key}) : super(key: key);

  @override
  _RequestPersmissionPageState createState() => _RequestPersmissionPageState();
}

class _RequestPersmissionPageState extends State<RequestPersmissionPage>
    with WidgetsBindingObserver {
  bool _fromSettings = false; // configuración manual

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _fromSettings) {
      // Si vuelvo a la app, comprobar si tengo acceso a la ubicación
      this._check();
    }
  }

  _check() async {
    final bool hasAccess = await Permission.locationWhenInUse.isGranted;
    if (hasAccess) {
      this._gotToHome();
    }
  }

  _gotToHome() {
    Navigator.pushReplacementNamed(context, HomePage.route);
  }

  _openAppSettings() async {
    await openAppSettings(); // Método en 'permission_handler'
    _fromSettings = true;
  }

  Future<void> _request() async {
    // Diálogo de acceso al dispositivo
    final PermissionStatus status =
        await Permission.locationWhenInUse.request();
    switch (status) {
      case PermissionStatus.undetermined:
        break;
      case PermissionStatus.granted:
        this._gotToHome();
        break;
      case PermissionStatus.denied:
        // Comprobar si el dispositivo es ios o android
        if (Platform.isIOS) {
          this._openAppSettings();
        }
        break;
      case PermissionStatus.restricted:
        break;
      case PermissionStatus.permanentlyDenied:
        /* En este caso, ya no mostrará el diálogo (deberá ir a los ajustes de app)
      y activar el acceso a la ubicación manualmente */
        this._openAppSettings();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Permiso requerido',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'Necsitamos permiso para acceder a la ubicación de tu dispositivo para brindarte nuestro servicio ',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w300)),
          ),
          FlatButton(
            color: Colors.blue,
            onPressed: this._request,
            child: Text('Permitir', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    ));
  }
}
