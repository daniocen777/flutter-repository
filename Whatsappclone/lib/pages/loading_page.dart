import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  static String route = 'loading';

  const LoadingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text('Usuarios')));
  }
}
