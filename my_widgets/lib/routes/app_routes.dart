import 'package:flutter/material.dart';
import 'package:my_widgets/pages/color_picker.dart';
import 'package:my_widgets/pages/dialogs_page.dart';
import 'package:my_widgets/pages/login_page.dart';
import 'package:my_widgets/pages/menu_pages.dart';
import 'package:my_widgets/pages/splash_page.dart';
import 'package:my_widgets/routes/route.dart';

// import 'package:my_widgets/routes/route.dart';

T? getArguments<T>(BuildContext context) {
  return ModalRoute.of(context)!.settings.arguments as T;
}

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.splash: (_) => const SplahPage(),
    Routes.home: (_) => const MenuPage(),
    Routes.dialogs: (_) => const DialogsPage(),
    // Para pasar datos a la página, es necesario context
    Routes.login: (context) {
      /* ünica forma de pasar data usando nombres de rutas */
      final email = getArguments<String>(context);
      return LoginPage(
        email: email,
      );
    },
    Routes.colorPicker: (_) => const ColorPicker()
  };
}
