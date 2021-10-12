import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight fontWeight;

  const CustomText(
      {Key? key,
      required this.text,
      this.size = 16.0,
      this.color = Colors.black87,
      this.fontWeight = FontWeight.normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(this.text,
        style: TextStyle(
            fontSize: this.size,
            color: this.color,
            fontWeight: this.fontWeight));
  }
}
