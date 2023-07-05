import 'package:flutter/material.dart';
/* import 'package:my_widgets/facebook_ui/facebook_ui.dart'; */
import 'package:my_widgets/routes/app_routes.dart';
import 'package:my_widgets/routes/route.dart';
import 'package:my_widgets/utils/app_theme.dart';

void main() => runApp(const MyApp());
// https://github.com/darwin-morocho/flutter-desde-cero-2022

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // GestureDetector para minimizar texFields
    return GestureDetector(
      onTap: () {
        /* final focus = FocusScope.of(context);
        final focusedChild = focus.focusedChild;
        if (focusedChild != null && !focusedChild.hasPrimaryFocus) {
          focusedChild.unfocus();
        } */
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: getThemeData(context),
        routes: appRoutes,
        initialRoute: Routes.splash,
      ),
    );
  }
}
