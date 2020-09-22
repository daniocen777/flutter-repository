import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String route;
  final String question;
  final String action;

  const Labels(
      {Key key,
      @required this.route,
      @required this.question,
      @required this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(this.question,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w300)),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, this.route);
            },
            child: Text(this.action,
                style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
