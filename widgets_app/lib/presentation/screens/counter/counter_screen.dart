import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/counter_provider.dart';

// Para usar los providers de riverpod, se usa "ConsumerWidget" (en el build, agregar la referencia WidgetRef )
class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  static const name = 'counter';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int counterValue =
        ref.watch(counterProvider); // pendiente del counterProvider
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter con Riverpod'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
