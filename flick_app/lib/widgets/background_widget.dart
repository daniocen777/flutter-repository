import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final double height;
  final double width;
  const BackgroundWidget({Key? key, required this.height, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: const DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://www.playerone.vg/wp-content/uploads/2021/06/aloy-horizon-dawn-diseno.jpg'))),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: Container(
                decoration:
                    BoxDecoration(color: Colors.black.withOpacity(0.2)))));
  }
}
