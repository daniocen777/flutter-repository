import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final bool fullWidth;
  final EdgeInsets padding;

  const CustomButton(
      {Key? key,
      required this.label,
      required this.onPressed,
      this.backgroundColor = Colors.white,
      this.textColor = Colors.black87,
      this.fullWidth = false,
      this.padding =
          const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 30.0,
      padding: EdgeInsets.zero,
      child: Container(
        width: fullWidth ? double.infinity : null,
        padding: this.padding,
        child: Text(this.label,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: this.textColor,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w500)),
        decoration: BoxDecoration(
            color: this.backgroundColor,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black38,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 5.0))
            ]),
      ),
      onPressed: () {
        FocusScope.of(context).unfocus(); // Cerrar teclado
        this.onPressed();
      },
    );
  }
}
