import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/* import 'package:flutter/widgets.dart'; */

class Dialogs {
  static void alert(BuildContext context, {String title, String description}) {
    showDialog(
        context: context,
        child: CupertinoAlertDialog(
          title: (title != null) ? Text(title) : null,
          content: (description != null) ? Text(description) : null,
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Ok'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ));
  }
}

class ProgressDialog {
  final BuildContext context;

  ProgressDialog(this.context);

  void show() {
    showCupertinoModalPopup(
        context: this.context,
        builder: (BuildContext context) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white.withOpacity(0.7),
            child: CupertinoActivityIndicator(
              radius: 15.0,
            ),
          );
        });
  }

  void dismiss() {
    Navigator.pop(context);
  }
}
