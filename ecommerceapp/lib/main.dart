import 'package:ecommerceapp/consts/theme.dart';
import 'package:ecommerceapp/providers/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/initial_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider _darkThemeProvider = DarkThemeProvider();

  void getCurrentTheme() async {
    this._darkThemeProvider.darkTheme =
        await this._darkThemeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    super.initState();
    this.getCurrentTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) {
            return _darkThemeProvider;
          }),
        ],
        child:
            Consumer<DarkThemeProvider>(builder: (context, themeDate, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Ecommerce App',
            theme: Styles.themeData(_darkThemeProvider.darkTheme, context),
            home: InitialPage(),
          );
        }));
  }
}
