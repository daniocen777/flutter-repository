import 'package:flutter/material.dart';

class CircularProgressWidget extends StatelessWidget {
  const CircularProgressWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 12.0),
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.lightBlueAccent)),
    );
  }
}

class LinearProgrssWidget extends StatelessWidget {
  const LinearProgrssWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 12.0),
      child: LinearProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.lightGreenAccent)),
    );
  }
}
