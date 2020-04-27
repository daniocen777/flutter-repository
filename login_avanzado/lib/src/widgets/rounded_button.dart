import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_avanzado/src/utils/app_colors.dart';

class RoundedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const RoundedButton(
      {Key key,
      @required this.label,
      @required this.onPressed,
      this.backgroundColor})
      : assert(label != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
          decoration: BoxDecoration(
              color: this.backgroundColor ?? AppColors.primary,
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5.0)]),
          child: Text(this.label,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'sans',
                  letterSpacing: 1.0,
                  fontSize: 18.0)),
        ),
        onPressed: this.onPressed);
  }
}
