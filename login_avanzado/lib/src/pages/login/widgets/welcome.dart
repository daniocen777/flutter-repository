import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_avanzado/src/utils/responsive.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key key}) : super(key: key);

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
                      Container(
                        width: constraint.maxWidth,
                        height: 3.0,
                        color: Color(0xffeeeeee),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Welcome!',
                        style: TextStyle(
                            fontSize: responsive.ip(2.5),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'raleway'),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  left: 0.0,
                  child: SvgPicture.asset('assets/images/login/clouds.svg',
                      width: constraint.maxWidth,
                      height: constraint.maxHeight * 0.7),
                ),
                Positioned(
                  top: constraint.maxHeight * 0.27,
                  child: SvgPicture.asset(
                    'assets/images/login/woman.svg',
                    width: constraint.maxWidth * 0.35,
                  ),
                ),
                Positioned(
                  top: constraint.maxHeight * 0.31,
                  right: 5.0,
                  child: SvgPicture.asset(
                    'assets/images/login/man.svg',
                    width: constraint.maxWidth * 0.26,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
