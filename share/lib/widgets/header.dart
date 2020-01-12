import 'package:flutter/material.dart';

header(BuildContext context, {bool isAppTitle = false, String title}) {
  return AppBar(
    title: Text(
      isAppTitle ? "FlutterShare" : title,
      style: TextStyle(
          color: Colors.white,
          fontFamily: isAppTitle ? "Signatra" : "",
          fontSize: isAppTitle ? 40.0 : 22.0),
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).accentColor,
  );
}
