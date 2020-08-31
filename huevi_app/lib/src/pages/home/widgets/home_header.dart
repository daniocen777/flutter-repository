import 'package:flutter/material.dart';
import 'package:huevi_app/src/utils/app_colors.dart';

import 'package:huevi_app/src/utils/responsive.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: AspectRatio(
            aspectRatio: 16 / 11,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final Responsive responsiveHeader = Responsive.fromSize(
                    Size(constraints.maxWidth, constraints.maxHeight));
                return Stack(
                  children: <Widget>[
                    ClipPath(
                        clipper: _MyCustomClipper(),
                        child: Container(color: AppColors.primary)),
                    /* Positioned(
                        bottom: 0.0,
                        right: 0.0,
                        child: WebsafeSvg.asset('assets/pages/home/happy.svg',
                            width: constraints.maxWidth * 0.55)), */
                    Positioned(
                        bottom: constraints.maxHeight * 0.7,
                        left: 10.0,
                        child: Text('Advertencia, esto es...',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: responsiveHeader.ip(5.0)))),
                    Positioned(
                        bottom: constraints.maxHeight * 0.3,
                        left: 10.0,
                        child: Text('HueviApp',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Signatra',
                                fontSize: responsiveHeader.ip(15.0)))),
                  ],
                );
              },
            )));
  }
}

class _MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height * 0.9);
    path.arcToPoint(Offset(size.width, size.height * 0.5),
        radius: Radius.circular(size.width), clockwise: false);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
