import 'package:flutter/material.dart';

class ButtonBlue extends StatelessWidget {
  final String label;
  final Function onPressed;

  const ButtonBlue({Key key,this.label, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: this.onPressed,
      elevation: 2.0,
      highlightElevation: 5.0,
      color: Colors.blue,
      shape: StadiumBorder(),
      child: Container(
          width: double.infinity,
          height: 55.0,
          child: Center(
              child: Text(this.label,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  )))),
    );
  }
}
