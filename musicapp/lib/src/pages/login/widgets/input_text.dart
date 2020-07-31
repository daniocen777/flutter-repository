import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:websafe_svg/websafe_svg.dart';

class InputText extends StatelessWidget {
  final String iconPath;
  final String placeholder;

  const InputText(
      {Key key, @required this.iconPath, @required this.placeholder})
      : assert(iconPath != null && placeholder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 5.0),
      style: TextStyle(fontFamily: 'sans'),
      prefix: Container(
        width: 40.0,
        height: 30.0,
        padding: EdgeInsets.all(2.0),
        child: WebsafeSvg.asset(this.iconPath, color: Color(0xffdddddd)),
      ),
      placeholder: this.placeholder,
      placeholderStyle: TextStyle(fontFamily: 'sans', color: Color(0xffdddddd)),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1.0, color: Color(0xffdddddd)))),
    );
  }
}
