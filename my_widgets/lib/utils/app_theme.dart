import 'package:flutter/material.dart';
import 'package:my_widgets/utils/material_color_generator.dart';

ThemeData getThemeData(BuildContext context) {
  return ThemeData(
    fontFamily: 'Nunito',
    primarySwatch: generateMaterialColor(
      const Color(0xffd81b60),
    ),
    colorScheme: const ColorScheme.light(primary: Colors.blueAccent),
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2.0, color: Colors.amber),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2.0, color: Colors.black12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2.0),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(Colors.pinkAccent),
      checkColor: MaterialStateProperty.all(Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      overlayColor: MaterialStateProperty.all(Colors.blueGrey.withOpacity(0.2)),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(Colors.pinkAccent),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(Colors.amber),
      trackColor: MaterialStateProperty.all(Colors.amber),
    ),
    sliderTheme: SliderThemeData(
      trackHeight: 15.0,
      activeTickMarkColor: Colors.pinkAccent,
      thumbColor: Colors.pink, // bola
      overlayColor: Colors.pink.withOpacity(0.1),
      valueIndicatorColor: Colors.redAccent,
      inactiveTickMarkColor: Colors.pink.withOpacity(0.2),
      disabledInactiveTickMarkColor: Colors.white54,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 15),
    ),
  );
}
