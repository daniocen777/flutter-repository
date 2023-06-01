import 'package:flutter/cupertino.dart';

Future<int> showDialogWithCupertinoStyle(BuildContext context,
    {String title = '', String content = ''}) async {
  final result = await showCupertinoDialog<int>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context, 1),
              ),
              CupertinoDialogAction(
                child: const Text('Holas'),
                onPressed: () => Navigator.pop(context, 2),
              ),
              CupertinoDialogAction(
                child: const Text('Adiós'),
                onPressed: () => Navigator.pop(context, 3),
              )
            ],
          ));
  return result ?? 1;
}
