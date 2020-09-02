import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class AvatarButton extends StatelessWidget {
  final double imageSize;
  const AvatarButton({Key key, this.imageSize = 100.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20.0,
                      offset: Offset(0.0, 20.0))
                ]),
            child: ClipOval(
              child: WebsafeSvg.asset('assets/avatar.svg',
                  width: this.imageSize, height: this.imageSize),
            )),
        Positioned(
          bottom: 5.0,
          right: 0.0,
          child: CupertinoButton(
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.circular(30.0),
              child: Container(
                  padding: EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      color: Colors.pink,
                      border: Border.all(color: Colors.white, width: 2.0),
                      shape: BoxShape.circle),
                  child: Icon(Icons.add, color: Colors.white)),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
      ],
    );
  }
}
