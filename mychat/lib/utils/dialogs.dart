import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class Dialogs {
  static Future<void> alert(BuildContext context,
      {String? title, String? body, String okText = 'Aceptar'}) async {
    final Completer<void> completer = Completer();
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: (title != null)
              ? Text(title, style: TextStyle(color: Colors.red))
              : null,
          content: (body != null) ? Text(body) : null,
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(okText),
              onPressed: () {
                Navigator.pop(context);
                completer.complete();
              },
            )
          ],
        );
      },
    );

    return completer.future;
  }
}
