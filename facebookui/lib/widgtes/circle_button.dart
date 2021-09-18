import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Function()? onTap;
  final double iconSize;
  final IconData icon;

  const CircleButton(
      {Key? key, required this.onTap, this.iconSize = 30.0, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration:
          BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
      child: IconButton(
          onPressed: this.onTap,
          icon: Icon(this.icon),
          iconSize: this.iconSize,
          color: Colors.black),
    );
  }
}
