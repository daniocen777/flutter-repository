import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/theme/app_theme.dart';

/* 
  Provider => Para valores inmutables (que no van a cambiar)
  StateProvider => Para mantener un estado (pendiente del cambio)
  StateNotifierProvider => Para estados más elaborados (customizado)
 */

final isDarkModeProvider = StateProvider((ref) => false);
// Provider inmutable
final colorListProvider = Provider((ref) => colorList);
// Para el cambio de colores (enteros)
final selectedColorProvider = StateProvider((ref) => 0);
// Objeto para el cambio de tema (en vez de hacerlo por separado)
final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, AppTheme>((ref) => ThemeNotifier());

// Mantener un estado en particular (controlador)
class ThemeNotifier extends StateNotifier<AppTheme> {
  // Crear la instancia de las clase
  ThemeNotifier() : super(AppTheme());

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void changeColorIndex(int colorIndex) {
    state = state.copyWith(selectedColor: colorIndex);
  }
}
