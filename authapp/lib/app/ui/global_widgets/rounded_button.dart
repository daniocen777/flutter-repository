import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const RoundedButton({Key? key, this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            textStyle:
                MaterialStateProperty.all(const TextStyle(fontSize: 15.0)),
            elevation: MaterialStateProperty.all(7.0),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)))),
        onPressed: onPressed,
        child: Text(text));
  }
}
