import 'package:flutter/material.dart';

class ShoesSizeItem extends StatelessWidget {
  final String text;
  const ShoesSizeItem({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(5.0),
        child: Text('UD $text',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0)));
  }
}
