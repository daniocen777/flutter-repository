import 'package:flutter/cupertino.dart';

mostrarAlerta(BuildContext context, {String title, String subtitle}) {
  return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(subtitle),
            actions: <Widget>[
              CupertinoDialogAction(
                  child: Text('OK'), onPressed: () => Navigator.pop(context))
            ],
          ));
}
