import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/font_style.dart';
import '../utils/colors.dart';

class RoundedButton extends StatelessWidget {
  final String label;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final bool fullWidth;
  final EdgeInsets padding;
  final VoidCallback onPressed;

  const RoundedButton(
      {Key? key,
      required this.label,
      this.textColor = Colors.white,
      this.backgroundColor = primaryColor,
      this.borderColor = primaryColor,
      this.fullWidth = true,
      this.padding =
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
      required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        minSize: 30.0,
        child: Container(
          width: this.fullWidth ? double.infinity : null,
          padding: this.padding,
          child: Text(
            this.label,
            textAlign: TextAlign.center,
            style: FontStyle.normal
                .copyWith(fontWeight: FontWeight.w700, color: this.textColor),
          ),
          decoration: BoxDecoration(
            color: this.backgroundColor,
            border: Border.all(width: 1.4, color: this.borderColor),
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: this.onPressed);
  }
}
