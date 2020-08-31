import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huevi_app/src/utils/responsive.dart';
import 'package:websafe_svg/websafe_svg.dart';

class MyAppBar extends StatelessWidget {
  final String leftIcon;
  final String rightIcon;
  final VoidCallback onLeftClick;
  final VoidCallback onRightClick;
  final Size size;

  const MyAppBar(
      {Key key,
      @required this.leftIcon,
      @required this.rightIcon,
      this.onLeftClick,
      this.onRightClick,
      this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsiveHeader = Responsive.fromSize(
        Size(this.size.width * 0.7, this.size.height * 0.9));
    return Container(
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CupertinoButton(
            padding: EdgeInsets.all(15.0),
            child: WebsafeSvg.asset(
              leftIcon,
              width: 35.0,
              color: Colors.white,
            ),
            onPressed: onLeftClick,
          ),
          Expanded(
            child: Center(
              child: Text('Zona de videos',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Signatra',
                      fontSize: responsiveHeader.ip(5.0))),
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.all(0.0),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: WebsafeSvg.asset(
                    rightIcon,
                    width: 35.0,
                    color: Colors.white,
                  ),
                ),
                /* Positioned(
                  right: 12.0,
                  top: 12.0,
                  child: Container(
                    width: 15.0,
                    height: 15.0,
                    decoration: BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                  ),
                ) */
              ],
            ),
            onPressed: onRightClick,
          ),
        ],
      ),
    );
  }
}
