part of 'helpers.dart';

void calculateAlert(BuildContext context) {
  // Alerta tipo ios
  showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text('Wait, please...'),
            content: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: CupertinoActivityIndicator(),
            ),
          ));
}
