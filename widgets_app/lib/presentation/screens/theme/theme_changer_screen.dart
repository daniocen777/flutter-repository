import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/theme_provider.dart';

class ThemeChangerScreen extends ConsumerWidget {
  const ThemeChangerScreen({super.key});

  static const name = 'theme_changer_screen';

  @override
  Widget build(BuildContext context, ref) {
    // final bool isDarkMode = ref.watch(isDarkModeProvider);
    final bool isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cambiar tema'),
        actions: [
          IconButton(
            /* onPressed: () =>
                ref.read(isDarkModeProvider.notifier).update((state) => !state), */
            onPressed: () {
              ref.read(themeNotifierProvider.notifier).toggleDarkMode();
            },
            icon: Icon(isDarkMode
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined),
          ),
        ],
      ),
      body: const _ThemeChangedView(),
    );
  }
}

class _ThemeChangedView extends ConsumerWidget {
  const _ThemeChangedView();

  @override
  Widget build(BuildContext context, ref) {
    final List<Color> colors = ref.watch(colorListProvider);
    // final int selectedColor = ref.watch(selectedColorProvider);
    final int selectedColor = ref.watch(themeNotifierProvider).selectedColor;
    return ListView.builder(
      itemCount: colors.length,
      itemBuilder: (BuildContext context, int index) {
        final color = colors[index];
        return RadioListTile(
          title: Text(
            'Tipo de color',
            style: TextStyle(color: color),
          ),
          subtitle: Text('De color: ${color.value}'),
          activeColor: color,
          value: index,
          groupValue: selectedColor,
          onChanged: (value) {
            // Notificar cambio (no se necesita el valor anterior)
            // ref.read(selectedColorProvider.notifier).state = index;
            ref.read(themeNotifierProvider.notifier).changeColorIndex(index);
          },
        );
      },
    );
  }
}
