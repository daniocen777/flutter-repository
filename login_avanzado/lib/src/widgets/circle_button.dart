import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_avanzado/src/utils/app_colors.dart';

class CircleButton extends StatelessWidget {
  final double size;
  final Color backgroundColor;
  final String iconPath;
  final VoidCallback onPressed;

  const CircleButton(
      {Key key,
      this.size = 50.0,
      this.backgroundColor,
      @required this.iconPath,
      @required this.onPressed})
      : assert(iconPath != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Container(
          width: this.size,
          height: this.size,
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              color: this.backgroundColor ?? AppColors.primary,
              shape: BoxShape.circle),
          child: SvgPicture.asset(this.iconPath, color: Colors.white)),
      onPressed: this.onPressed,
    );
  }
}
