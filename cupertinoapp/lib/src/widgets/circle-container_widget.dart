import 'package:flutter/material.dart';

class CircleContainer extends StatelessWidget {
  final Widget child;
  final double size;

  const CircleContainer(
      {Key key,
      @required this.child,
      @required this.size})
      : assert(child != null),
        assert(size != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size,
      height: this.size,
      alignment: Alignment.center,
      child: child,
      decoration: BoxDecoration(
          color: Color(0xfff0f0f0),
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(5.0, 5.0))
          ]),
    );
  }
}
