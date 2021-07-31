import 'package:flutter/widgets.dart';

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, 4 * size.height / 5);
    Offset curveLeftPoint = new Offset(size.width / 4, size.height);
    Offset centerPoint = new Offset(size.width / 2, 4 * size.height / 5);
    path.quadraticBezierTo(
        curveLeftPoint.dx, curveLeftPoint.dy, centerPoint.dx, centerPoint.dy);

    Offset curveRighttPoint =
        new Offset(3 * size.width / 4, 3 * size.height / 5);
    Offset endPoint = new Offset(size.width, 4 * size.height / 5);
    path.quadraticBezierTo(
        curveRighttPoint.dx, curveRighttPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
