import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Cargando películas',
      'Comprando canchita',
      'Cargando populares',
      'Cargando mejor calificadas',
      'Cargando en cines',
    ];
    return Stream.periodic(
        const Duration(
          milliseconds: 1200,
        ), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Esperar'),
          const SizedBox(height: 10.0),
          const CircularProgressIndicator(strokeWidth: 2.0),
          const SizedBox(height: 10.0),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (BuildContext context, snapshot) {
              if (!snapshot.hasData) return const Text('Cargando');
              return Text(snapshot.data!);
            },
          )
        ],
      ),
    );
  }
}
