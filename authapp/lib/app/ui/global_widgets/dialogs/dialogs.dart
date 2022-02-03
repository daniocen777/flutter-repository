import 'package:flutter/cupertino.dart';

abstract class Dialogs {
  static Future<void> alert(BuildContext context,
      {String? title, String? content, String okText = 'OK'}) {
    return showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: title != null
                  ? Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    )
                  : null,
              content: content != null ? Text(content) : null,
              actions: [
                CupertinoDialogAction(
                  child: Text(okText),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ));
  }
}
