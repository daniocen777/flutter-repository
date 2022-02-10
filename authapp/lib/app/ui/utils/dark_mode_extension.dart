/* Para que las demás páginas queden en el mismo tema al ir a otra página */
import 'package:flutter/material.dart';

extension ThemeContextExtension on BuildContext {
  bool get isThemeDarkMode {
    return Theme.of(this).brightness == Brightness.dark;
  }
}
