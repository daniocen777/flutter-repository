import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class LeftRifgtIconButton extends StatelessWidget {
  final String leftIcon;
  final String label;
  final Widget rightContent;
  final VoidCallback onPressed;

  const LeftRifgtIconButton(
      {Key key,
      this.leftIcon,
      this.label = '',
      this.onPressed,
      this.rightContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    if (leftIcon != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: WebsafeSvg.asset(leftIcon, width: 30.0),
                      ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black)),
                      ),
                    ),
                  ],
                ),
              ),
              if (rightContent != null)
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: rightContent),
            ],
          )),
    );
  }
}
