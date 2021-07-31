import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:uiuxapp/src/utils/colors.dart';

class CircleButton extends StatelessWidget {
  final String iconPath;
  final double size;
  final Color backgroundColor;
  final Color icoColor;
  final VoidCallback onPressed;

  const CircleButton(
      {Key? key,
      required this.iconPath,
      this.size = 35.0,
      this.backgroundColor = primaryColor,
      this.icoColor = Colors.white,
      required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        child: Container(
            width: this.size,
            height: this.size,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: this.backgroundColor, shape: BoxShape.circle),
            child: SvgPicture.asset(
              this.iconPath,
              color: this.icoColor,
            )),
        onPressed: this.onPressed);
  }
}
