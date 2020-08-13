import 'package:flutter/material.dart';

import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:musicapp/src/db/app_theme.dart';
import 'package:musicapp/src/pages/home/widgets/bird.dart';

import 'package:musicapp/src/pages/home/widgets/my_avatar.dart';
import 'package:musicapp/src/utils/responsive.dart';
import 'package:websafe_svg/websafe_svg.dart';

class HomeHeader extends StatelessWidget {
  final GlobalKey<InnerDrawerState> drawerKey;

  const HomeHeader({Key key, @required this.drawerKey})
      : assert(drawerKey != null),
        super(key: key);

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
                        child: Container(color: Color(0xff01579b))),
                    Positioned(
                        bottom: 0.0,
                        right: 0.0,
                        child: WebsafeSvg.asset('assets/pages/home/happy.svg',
                            width: constraints.maxWidth * 0.55)),
                    Positioned(
                        bottom: constraints.maxHeight * 0.09,
                        right: constraints.maxWidth * 0.163,
                        child: Bird(size: constraints.maxWidth * 0.22)),
                    Positioned(
                      top: 10.0,
                      right: 10.0,
                      child: SafeArea(child: MyAvatar(
                        onPressed: () {
                          drawerKey.currentState.open();
                        },
                      )),
                    ),
                    Positioned(
                        bottom: constraints.maxHeight * 0.2,
                        left: 10.0,
                        child: Text('Welcome back\n My Friend',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: responsiveHeader.ip(5.0)))),
                    Positioned(
                      top: 10.0,
                      left: 10.0,
                      child: SafeArea(
                          child: Row(
                        children: <Widget>[
                          Text('Dark mode',
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          Switch(
                            value: MyAppTheme.instance.darkEnabled,
                            onChanged: (value) {
                              MyAppTheme.instance.setTheme(value);
                            },
                          ),
                        ],
                      )),
                    )
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
