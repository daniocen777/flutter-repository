import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class DialogOption {
  final String label;
  final dynamic value;

  DialogOption({@required this.label, @required this.value});
}

class Dialogs {
  static Future<void> alert(BuildContext context,
      {String title, String body, String okText = 'Aceptar'}) async {
    final Completer<void> completer = Completer();
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: (title != null) ? Text(title) : null,
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

  static Future<bool> materialConfirm(BuildContext context,
      {String title,
      String body,
      String confirmText = 'Aceptar',
      String cancelText = 'Cancelar'}) async {
    final Completer<bool> completer = Completer();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: (title != null) ? Text(title) : null,
            content: (body != null) ? Text(body) : null,
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    completer.complete(true);
                  },
                  child: Text(confirmText,
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w300))),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    completer.complete(false);
                  },
                  child: Text(cancelText,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300)))
            ],
          );
        });

    return completer.future;
  }

  static Future<bool> cupertinoConfirm(BuildContext context,
      {String title,
      String body,
      String confirmText = 'Aceptar',
      String cancelText = 'Cancelar'}) async {
    final Completer<bool> completer = Completer();

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.transparent,
          alignment: Alignment.bottomCenter,
          child: CupertinoActionSheet(
            title: (title != null)
                ? Text(title,
                    style: TextStyle(color: Colors.black, fontSize: 20.0))
                : null,
            message: (body != null)
                ? Text(body, style: TextStyle(fontSize: 15.0))
                : null,
            actions: <Widget>[
              CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                    completer.complete(true);
                  },
                  child: Text(confirmText,
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300)))
            ],
            cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  completer.complete(false);
                },
                child: Text(cancelText,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300))),
          ),
        );
      },
    );

    return completer.future;
  }

  static Future<dynamic> select(BuildContext context,
      {String title,
      String body,
      @required List<DialogOption> options,
      String cancelText = 'Cancelar'}) async {
    final Completer<dynamic> completer = Completer();

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.transparent,
          alignment: Alignment.bottomCenter,
          child: CupertinoActionSheet(
            title: (title != null)
                ? Text(title,
                    style: TextStyle(color: Colors.black, fontSize: 20.0))
                : null,
            message: (body != null)
                ? Text(body, style: TextStyle(fontSize: 15.0))
                : null,
            actions: List.generate(options.length, (index) {
              final DialogOption option = options[index];
              return CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                    completer.complete(option.value);
                  },
                  child: Text(option.label,
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300)));
            }),
            cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  completer.complete(null);
                },
                child: Text(cancelText,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300))),
          ),
        );
      },
    );

    return completer.future;
  }

  static void input(BuildContext context,
      {String label,
      String placeholder,
      @required void Function(String) onOk}) {
    String text = '';
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: (label != null)
                ? Text(label, style: TextStyle(color: Colors.black))
                : null,
            content: CupertinoTextField(
              placeholder: placeholder,
              onChanged: (String _text) {
                text = _text;
              },
            ),
            actions: <Widget>[
              CupertinoButton(
                  child: Text('Aceptar'),
                  onPressed: () {
                    Navigator.pop(context);
                    onOk(text);
                  })
            ],
          );
        });
  }
}

