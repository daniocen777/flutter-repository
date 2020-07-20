import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

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

  static void inputEmail(BuildContext context,
      {String label,
      String placeholder,
      @required void Function(String) onOk}) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
              title: (label != null)
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(label, style: TextStyle(color: Colors.black)),
                    )
                  : null,
              content: InputEmail(
                placeholder: placeholder,
                onOk: (value) {
                  if (onOk != null) {
                    onOk(value);
                  }
                },
              ));
        });
  }
}

class InputEmail extends StatefulWidget {
  final String placeholder;
  final void Function(String) onOk;

  InputEmail({Key key, this.placeholder, @required this.onOk})
      : super(key: key);

  @override
  _InputEmailState createState() => _InputEmailState();
}

class _InputEmailState extends State<InputEmail> {
  String _email = '';

  bool _validate() {
    return _email.contains('@');
  }

  @override
  Widget build(BuildContext context) {
    final isValid = _validate();

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CupertinoTextField(
            placeholder: widget.placeholder,
            onChanged: (String value) {
              _email = value;
              _validate();
              setState(() {});
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child:
                        Text('Cancelar', style: TextStyle(color: Colors.red))),
              ),
              Expanded(
                child: FlatButton(
                    onPressed: isValid
                        ? () {
                            Navigator.pop(context);
                            widget.onOk(_email);
                          }
                        : null,
                    child: Text('Aceptar',
                        style: TextStyle(
                            color: isValid ? Colors.blue : Colors.black45))),
              )
            ],
          )
        ],
      ),
    );
  }
}
