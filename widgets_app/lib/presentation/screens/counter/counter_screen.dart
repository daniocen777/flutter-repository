import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/counter_provider.dart';
import '../../providers/theme_provider.dart';

// Para usar los providers de riverpod, se usa "ConsumerWidget" (en el build, agregar la referencia WidgetRef )
class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  static const name = 'counter';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int counterValue =
        ref.watch(counterProvider); // pendiente del counterProvider
    final bool isDarkMode = ref.watch(isDarkModeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter con Riverpod'),
        actions: [
          IconButton(
            onPressed: () =>
                ref.read(isDarkModeProvider.notifier).update((state) => !state),
            icon: Icon(isDarkMode
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Cambiar valores y pendiente de los cambios
          // 1° forma => ref.read(counterProvider.notifier).state++;
          // otra forma (valorActual)
          ref.read(counterProvider.notifier).update((state) => state + 1);
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'valor: $counterValue',
              style: Theme.of(context).textTheme.titleLarge,
            )
          ],
        ),
      ),
    );
  }
}
