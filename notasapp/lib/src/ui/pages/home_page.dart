import 'package:flutter/material.dart';

import '../../../src/core/controllers/theme_controller.dart';

GlobalKey<ScaffoldState> homePageKey = GlobalKey<ScaffoldState>();

class HomePage extends StatelessWidget {
  static const HOME_PAGE_ROUTE = 'home';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeController.instance;
    return ValueListenableBuilder(
      valueListenable: theme.brightness,
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
          key: homePageKey,
          backgroundColor: theme.background(),
          body: Center(
            child: Text('Holas'),
          ),
        );
      },
    );
  }
}
