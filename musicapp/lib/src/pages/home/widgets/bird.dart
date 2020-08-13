import 'package:flutter/material.dart';

import 'package:websafe_svg/websafe_svg.dart';
import 'dart:math' as math;

class Bird extends StatefulWidget {
  final double size;

  Bird({Key key, @required this.size}) : super(key: key);

  @override
  _BirdState createState() => _BirdState();
}

class _BirdState extends State<Bird> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _angle;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _angle = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween(begin: _toRadians(2.5), end: _toRadians(-2.5)),
          weight: 50.0),
      TweenSequenceItem<double>(
          tween: Tween(begin: _toRadians(-2.5), end: _toRadians(2.5)),
          weight: 50.0)
    ]).animate(_animationController);

    _angle.addListener(() {
      setState(() {});
    });

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  double _toRadians(double value) {
    return value * math.pi / 180;
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _angle.value,
      origin: Offset(0.0, widget.size * 0.4),
      child: WebsafeSvg.asset('assets/pages/home/bird.svg', width: widget.size),
    );
  }
}
