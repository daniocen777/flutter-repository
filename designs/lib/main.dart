import 'package:flutter/material.dart';

import 'package:designs/src/models/layout_model.dart';
import 'package:designs/src/pages/launcher_tablet_page.dart';
import 'package:designs/src/theme/theme.dart';
import 'package:designs/src/pages/launcher_page.dart';
import 'package:provider/provider.dart';

/* void main() => runApp(MultiProvider(
      providers: [
        Provider(
          create: (_) => new ThemeChanger(1),
        ),
        Provider(
          create: (_) => new LayoutModel(),
        )
      ],
    )); */

void main() => runApp(ChangeNotifierProvider(
    create: (_) => new LayoutModel(),
    child: ChangeNotifierProvider(
        create: (_) => new ThemeChanger(1), child: MyApp())));

/* void main() => runApp(
    ChangeNotifierProvider(create: (_) => new ThemeChanger(1), child: MyApp())); */

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return MaterialApp(
        theme: currentTheme,
        debugShowCheckedModeBanner: false,
        title: 'Diseños App',
        home: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            final screenSize = MediaQuery.of(context).size;

            if (screenSize.width > 500) {
              // Tableta
              return LauncherTabletPage();
            } else {
              // Teléfono
              return LauncherPage();
            }
          },
        ));
  }
}
