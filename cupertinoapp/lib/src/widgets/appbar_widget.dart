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
          Text('Logo',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
          CupertinoButton(
            padding: EdgeInsets.all(0.0),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: WebsafeSvg.asset(
                    rightIcon,
                    width: 35.0,
                  ),
                ),
                Positioned(
                  right: 12.0,
                  top: 12.0,
                  child: Container(
                    width: 15.0,
                    height: 15.0,
                    decoration: BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                  ),
                )
              ],
            ),
            onPressed: onRightClick,
          ),
        ],
      ),
    );
  }
}
