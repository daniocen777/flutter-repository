import 'package:flutter/material.dart';
import 'package:mytelegram/utils/colors.dart';

class CircularProgressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 12.0),
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(primaryColor)),
    );
  }
}

class LinearProgressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 12.0),
      child: LinearProgressIndicator(
          valueColor: AlwaysStoppedAnimation(secondColor)),
    );
  }
}
