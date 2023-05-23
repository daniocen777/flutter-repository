import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double size;
  final String asset;
  final double borderWith;

  const Avatar(
      {super.key,
      required this.size,
      required this.asset,
      this.borderWith = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: borderWith, color: Colors.white),
          image: DecorationImage(image: AssetImage(asset))),
    );
  }
}
