import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class MyAppBar extends StatelessWidget {
  final String leftIcon;
  final String rightIcon;
  final VoidCallback onLeftClick;
  final VoidCallback onRightClick;

  const MyAppBar(
      {Key key,
      @required this.leftIcon,
      @required this.rightIcon,
      this.onLeftClick,
      this.onRightClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CupertinoButton(
            padding: EdgeInsets.all(15.0),
            child: WebsafeSvg.asset(
              leftIcon,
              width: 35.0,
            ),
            onPressed: onLeftClick,
          ),
          Text('Chat Privado',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
          CupertinoButton(
            padding: EdgeInsets.all(15.0),
            child: WebsafeSvg.asset(
              rightIcon,
              width: 35.0,
            ),
            onPressed: onRightClick,
          ),
        ],
      ),
    );
  }
}
