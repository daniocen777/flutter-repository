import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const CustomButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = new Responsive.of(context);
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(this.color),
      ),
      child: Container(
        width: responsive.wp(35.0),
        height: 45.0,
        child: Center(
          child: Text(
            this.text,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15.0),
          ),
        ),
      ),
      onPressed: this.onPressed,
    );
  }
}
