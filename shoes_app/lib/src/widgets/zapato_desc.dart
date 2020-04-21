import 'package:flutter/material.dart';

class ZapatoDescripcion extends StatelessWidget {
  final String title;
  final String descript;

  const ZapatoDescripcion(
      {Key key, @required this.title, @required this.descript})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Text(this.title,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w700,
              )),
          SizedBox(
            height: 20.0,
          ),
          Text(this.descript,
              style: TextStyle(
                color: Colors.black54,
                height: 1.6,
              )),
        ],
      ),
    );
  }
}
