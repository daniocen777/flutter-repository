import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/responsive.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = new Responsive.of(context);
    return CupertinoButton(
      color: primaryColor,
      child: Container(
        width: responsive.wp(35.0),
        child: Center(
          child: Text(
            this.text,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0),
          ),
        ),
      ),
      onPressed: this.onPressed,
    );
  }
}
