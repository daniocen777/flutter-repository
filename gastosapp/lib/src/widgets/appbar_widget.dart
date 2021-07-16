import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  final Color color;
  final double? height;
  final double? price;

  const MyAppBar(
      {Key? key,
      required this.title,
      this.color = Colors.amber,
      this.height = 50.0,
      this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      color: this.color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          this.price != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text('S/ ${this.price.toString()}',
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.w700)),
                )
              : Container(
                  width: 0.0,
                  height: 0.0,
                ),
        ],
      ),
    );
  }
}
