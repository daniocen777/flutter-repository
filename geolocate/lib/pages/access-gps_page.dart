import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';

import 'package:geolocate/pages/loading_page.dart';

class AccessGpsPage extends StatefulWidget {
  static final String route = "gps";

  const AccessGpsPage({Key key}) : super(key: key);

  @override
  _AccessGpsPageState createState() => _AccessGpsPageState();
}

class _AccessGpsPageState extends State<AccessGpsPage>
    with WidgetsBindingObserver {
  bool popup = false;

  @override
  void initState() {
    super.initState();
    // Estar pendiente del estado de este widget
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // Cambios en el ciclo de vida del widget (inactive, paused, resumed)
    if (state == AppLifecycleState.resumed && !this.popup) {
      if (await Permission.location.isGranted) {
        Navigator.pushReplacementNamed(context, LoadingPage.route);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("Es necesario activar el GPS"),
        SizedBox(height: 10.0),
        CupertinoButton(
          child:
              Text("Solicitar accesso", style: TextStyle(color: Colors.white)),
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(20.0),
          onPressed: () async {
            this.popup = true;
            // Verificar permisos
            final status = await Permission.location.request();
            await this._gpsAccess(status);
          },
        )
      ])),
    );
  }

  Future<void> _gpsAccess(PermissionStatus status) async {
    switch (status) {
      case PermissionStatus.granted:
        await Navigator.pushReplacementNamed(context, LoadingPage.route);
        break;
      case PermissionStatus.undetermined:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
    }
  }
}
