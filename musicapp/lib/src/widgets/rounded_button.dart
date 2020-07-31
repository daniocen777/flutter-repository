import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicapp/src/utils/app_colors.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color backgroundColor;

  const RoundedButton(
      {Key key,
      @required this.onPressed,
      @required this.label,
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
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.black26, blurRadius: 5.0)
            ]),
        child: Text(this.label,
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'sans',
                letterSpacing: 1.0,
                fontSize: 15.0)),
      ),
      onPressed: this.onPressed,
    );
  }
}
