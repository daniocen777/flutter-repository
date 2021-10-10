import 'package:flutter/material.dart';

const int LARGUE_SCREEN_SIZE = 1366;
const int MEDIUM_SCREEN_SIZE = 768;
const int SMALL_SCREEN_SIZE = 369;
const int CUSTOM_SCREEN_SIZE = 1100;

class ResponsiveWidwet extends StatelessWidget {
  final Widget largueScreen;
  final Widget? mediumScreen;
  final Widget? smallScreen;
  final Widget? customScreen;

  const ResponsiveWidwet(
      {Key? key,
      required this.largueScreen,
      this.mediumScreen,
      this.smallScreen,
      this.customScreen})
      : super(key: key);

  static bool isSmallScreen(BuildContext context) =>
      MediaQuery.of(context).size.width < SMALL_SCREEN_SIZE;

  static bool isMediumScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= MEDIUM_SCREEN_SIZE &&
      MediaQuery.of(context).size.width < LARGUE_SCREEN_SIZE;

  static bool isLargueScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= LARGUE_SCREEN_SIZE;

  static bool isConstomcreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= MEDIUM_SCREEN_SIZE &&
      MediaQuery.of(context).size.width <= CUSTOM_SCREEN_SIZE;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double _width = constraints.maxWidth;
        if (_width >= LARGUE_SCREEN_SIZE) {
          return this.largueScreen;
        } else if (_width >= MEDIUM_SCREEN_SIZE &&
            _width < LARGUE_SCREEN_SIZE) {
          return this.mediumScreen ?? this.largueScreen;
        } else {
          return this.smallScreen ?? this.largueScreen;
        }
      },
    );
  }
}
