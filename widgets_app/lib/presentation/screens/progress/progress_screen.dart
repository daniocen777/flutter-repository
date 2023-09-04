import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  static const name = 'progress_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Indicators'),
      ),
      body: const _ProgressView(),
    );
  }
}

class _ProgressView extends StatelessWidget {
  const _ProgressView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          SizedBox(height: 30.0),
          Text('Circular Progress Indicator'),
          SizedBox(height: 10.0),
          CircularProgressIndicator(
            strokeWidth: 2.0,
            backgroundColor: Colors.black26,
          ),
          SizedBox(height: 20.0),
          Text('Circular y Linear Progress Indicator Controlado'),
          SizedBox(height: 10.0),
          _ControlledProgressIndicator()
        ],
      ),
    );
  }
}

class _ControlledProgressIndicator extends StatelessWidget {
  const _ControlledProgressIndicator();

  @override
  Widget build(BuildContext context) {
    // StreamBuilder => se contruye en tiempo de ejecución
    // StreamBuilder se destruye automáticamente
    return StreamBuilder(
        stream: Stream.periodic(const Duration(milliseconds: 300), (value) {
          return (value * 2) / 100; // 0.0 - 1.0
        }).takeWhile((value) => value < 100),
        builder: (context, snapshot) {
          final progressValue = snapshot.data ?? 0;
          return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    value: progressValue,
                    strokeWidth: 2.0,
                    backgroundColor: Colors.black26,
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                      child: LinearProgressIndicator(
                    value: progressValue,
                  ))
                ],
              ));
        });
  }
}
