import 'package:flutter/material.dart';

class LargueScreen extends StatelessWidget {
  const LargueScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: Container(color: Colors.red)),
      Expanded(flex: 5, child: Container(color: Colors.blue)),
    ]);
  }
}
