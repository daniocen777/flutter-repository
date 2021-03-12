import 'package:flutter/material.dart';

import 'package:chatprivado/utils/colors.dart';
import 'package:chatprivado/utils/responsive.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({Key key, @required this.text, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = new Responsive.of(context);
    return RaisedButton(
      elevation: 2.0,
      color: PRIMARY_COLOR,
      shape: StadiumBorder(),
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
