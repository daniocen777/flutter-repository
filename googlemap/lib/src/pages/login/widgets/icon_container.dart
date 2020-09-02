import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class IconContainer extends StatelessWidget {
  final double size;

  const IconContainer({Key key, @required this.size})
      : assert(size != null && size > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size,
      height: this.size,
      padding: EdgeInsets.all(this.size * 0.15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(this.size * 0.15),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black12,
                blurRadius: 25.0,
                offset: Offset(0.0, 15.0))
          ]),
      child: Center(
        child: WebsafeSvg.asset('assets/icon.svg',
            width: this.size * 0.6, height: this.size * 0.6),
      ),
    );
  }
}
