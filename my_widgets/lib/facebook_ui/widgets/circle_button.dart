import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Color color;
  final IconData iconData;
  final bool showBadge;

  const CircleButton(
      {super.key,
      required this.color,
      required this.iconData,
      this.showBadge = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(
              iconData,
              color: Colors.white,
              size: 16.0,
            ),
          ),
          if (showBadge)
            Positioned(
              top: -3.0,
              right: 0.0,
              child: Container(
                width: 13.0,
                height: 13.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                    border: Border.all(width: 3.0, color: Colors.white)),
              ),
            )
        ],
      ),
    );
  }
}
