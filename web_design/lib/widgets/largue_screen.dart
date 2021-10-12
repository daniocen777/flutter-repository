import 'package:flutter/material.dart';
import 'package:web_design/widgets/side_menu.dart';

class LargueScreen extends StatelessWidget {
  const LargueScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: SideMenu()),
      Expanded(flex: 5, child: Container(color: Colors.blue)),
    ]);
  }
}
