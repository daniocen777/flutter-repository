import 'package:flutter/material.dart';
import 'package:my_widgets/pages/color_picker.dart';
import 'package:my_widgets/pages/dialogs_page.dart';
import 'package:my_widgets/pages/inputs/calendar_page.dart';
import 'package:my_widgets/pages/inputs/chexk_box_page.dart';
import 'package:my_widgets/pages/inputs/cupertino_calendar_page.dart';
import 'package:my_widgets/pages/inputs/radio_page.dart';
import 'package:my_widgets/pages/inputs/slider_page.dart';
import 'package:my_widgets/pages/inputs/text_field_page.dart';
import 'package:my_widgets/pages/inputs/keyboard_types_page.dart';
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
    Routes.colorPicker: (_) => const ColorPicker(),
    Routes.textField: (_) => const TextFieldPage(),
    Routes.keyboardTypes: (_) => const KeyboardTypesPage(),
    Routes.checkBox: (_) => const CheckBoxPage(),
    Routes.radio: (_) => const RadioPage(),
    Routes.slider: (_) => const SliderPage(),
    Routes.calendar: (_) => const CalendarPage(),
    Routes.cupertinoCalendar: (_) => const CupertinoCalendarPage()
  };
}
