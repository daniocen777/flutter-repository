import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:geolocate/helpers/helpers.dart';
import 'package:geolocate/pages/map_page.dart';
import 'package:geolocate/pages/access-gps_page.dart';

class LoadingPage extends StatefulWidget {
  static final String route = 'loading';

  const LoadingPage({Key key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {
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
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await GeolocatorPlatform.instance.isLocationServiceEnabled()) {
        Navigator.pushReplacement(
            context, navigationFadeIn(context, MapPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: this._checkGpsLocation(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Center(child: Text(snapshot.data));
            } else {
              return Center(
                  child: CupertinoActivityIndicator(
                radius: 35.0,
              ));
            }
          }),
    );
  }

  Future _checkGpsLocation(BuildContext context) async {
    // Permiso de GPS
    final bool gpsPermission = await Permission.location.isGranted;
    // SI GPS está activo
    final bool gpsActive =
        await GeolocatorPlatform.instance.isLocationServiceEnabled();

    if (gpsPermission && gpsActive) {
      Navigator.pushReplacement(context, navigationFadeIn(context, MapPage()));
      return '';
    } else if (!gpsPermission) {
      Navigator.pushReplacement(
          context, navigationFadeIn(context, AccessGpsPage()));
      return 'Necesita los permisos del GPS';
    } else {
      return 'Debe activar el GPS';
    }

    //Navigator.pushReplacement(context, navigationFadeIn(context, MapPage()));
  }
}
