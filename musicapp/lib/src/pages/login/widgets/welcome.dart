import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:musicapp/src/utils/responsive.dart';

class Welcome extends StatelessWidget {
  final bool isLogin;

  const Welcome({Key key, this.isLogin = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = new Responsive.of(context);
    /* AspectRatio => Aspecto en entre el ancho y la altura*/
    return AspectRatio(
      aspectRatio: 16 / 11,
      child: LayoutBuilder(
        builder: (_, constraint) {
          return Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: constraint.maxHeight * 0.7,
                  child: Column(
                    children: <Widget>[
                      isLogin
                          ? Container(
                              width: constraint.maxWidth,
                              height: 3.0,
                              color: Color(0xffeeeeee),
                            )
                          : Container(),
                      SizedBox(height: 20.0),
                      isLogin
                          ? Text(
                              'Welcome!',
                              style: TextStyle(
                                  fontSize: responsive.ip(2.5),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'raleway'),
                            )
                          : Container(),
                    ],
                  ),
                ),
                isLogin
                    ? Positioned(
                        top: 0.0,
                        right: 0.0,
                        left: 0.0,
                        child: SvgPicture.asset('assets/pages/login/clouds.svg',
                            width: constraint.maxWidth,
                            height: constraint.maxHeight * 0.7),
                      )
                    : Positioned(
                        top: 0.0,
                        right: 0.0,
                        left: 0.0,
                        child: SvgPicture.asset('assets/pages/login/guys.svg',
                            width: constraint.maxWidth,
                            height: constraint.maxHeight * 0.7),
                      ),
                isLogin
                    ? Positioned(
                        top: constraint.maxHeight * 0.27,
                        child: SvgPicture.asset(
                          'assets/pages/login/woman.svg',
                          width: constraint.maxWidth * 0.35,
                        ),
                      )
                    : Container(),
                isLogin
                    ? Positioned(
                        top: constraint.maxHeight * 0.31,
                        right: 5.0,
                        child: SvgPicture.asset(
                          'assets/pages/login/man.svg',
                          width: constraint.maxWidth * 0.26,
                        ),
                      )
                    : Container()
              ],
            ),
          );
        },
      ),
    );
  }
}
