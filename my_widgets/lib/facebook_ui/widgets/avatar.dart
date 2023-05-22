import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double size;
  final String asset;

  const Avatar({super.key, required this.size, required this.asset});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.5),
        child: Image.asset(asset, width: size, height: size),
      ),
    );
  }
}
