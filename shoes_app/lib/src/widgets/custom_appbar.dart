import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String texto;

  const CustomAppBar({Key key, @required this.texto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        margin: EdgeInsets.only(top: 30.0),
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Text(this.texto,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                )),
            Spacer(),
            Icon(
              Icons.search,
              size: 25.0,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
