import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String title;

  const Logo({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170.0,
        margin: EdgeInsets.only(top: 45.0),
        child: Column(
          children: <Widget>[
            Image(image: AssetImage('assets/tag-logo.png')),
            SizedBox(height: 25.0),
            Text(this.title, style: TextStyle(fontSize: 25.0))
          ],
        ),
      ),
    );
  }
}
