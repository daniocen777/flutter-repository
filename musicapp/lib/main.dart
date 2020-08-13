import 'package:flutter/material.dart';
import 'package:musicapp/src/db/app_theme.dart';
import 'package:musicapp/src/db/db.dart';
import 'package:musicapp/src/pages/home/home_page.dart';
import 'package:musicapp/src/pages/login/forgot-password_page.dart';
import 'package:musicapp/src/pages/login/login_page.dart';
import 'package:musicapp/src/pages/login/register_page.dart';
import 'package:musicapp/src/pages/splash/splash_page.dart';

import 'package:provider/provider.dart';

void main() async {
  /* Para usar la BD Sembast */
  WidgetsFlutterBinding.ensureInitialized();
  await DB.instance.init();
  await MyAppTheme.instance.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: MyAppTheme.instance,
      child: Consumer<MyAppTheme>(
        builder: (BuildContext context, value, Widget child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Material App',
              theme: MyAppTheme.instance.theme,
              home: SplashPage(),
              routes: {
                SplashPage.routeName: (BuildContext context) => SplashPage(),
                LoginPage.routeName: (BuildContext context) => LoginPage(),
                RegisterPage.routeName: (BuildContext context) =>
                    RegisterPage(),
                ForgotPasswordPage.routeName: (BuildContext context) =>
                    ForgotPasswordPage(),
                HomePage.routeName: (BuildContext context) => HomePage()
              });
        },
      ),
    );
  }
}
