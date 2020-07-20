import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final bool fullWidth;
  final EdgeInsets padding;

  const MyButton(
      {Key key,
      @required this.label,
      this.onPressed,
      this.backgroundColor,
      this.textColor,
      this.fullWidth = false,
      this.padding})
      : assert(label != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 30.0,
      padding: EdgeInsets.zero,
      child: Container(
        width: fullWidth ? double.infinity : null,
        padding: this.padding ??
            EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
        child: Text(this.label,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: this.textColor ?? Colors.black,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w500)),
        decoration: BoxDecoration(
            color: this.backgroundColor ?? Colors.white,
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
