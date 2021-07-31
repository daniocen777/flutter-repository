import 'package:flutter/material.dart';

class MainShakeTransition extends StatelessWidget {
  const MainShakeTransition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData.dark(),
        child: Scaffold(
            appBar: AppBar(
              title: Text('Shake Transition'),
            ),
            body: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _ShakeTransition(
                          child: Text('Danicode',
                              style: Theme.of(context).textTheme.headline3)),
                      SizedBox(height: 20.0),
                      _ShakeTransition(
                          axis: Axis.vertical,
                          duration: Duration(milliseconds: 1500),
                          child: TextButton(
                              child: Text('Botón con transición'),
                              onPressed: () => print('Botón con transición')))
                    ]))));
  }
}

class _ShakeTransition extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final double offset; // Desplazamiento en pixeles
  final Axis axis;

  const _ShakeTransition(
      {Key? key,
      required this.child,
      this.duration = const Duration(milliseconds: 900),
      this.offset = 140.0,
      this.axis = Axis.horizontal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        child: child,
        duration: duration,
        curve: Curves.elasticOut,
        // De deracha a izquierda
        tween: Tween(begin: 1.0, end: 0.0),
        builder: (BuildContext context, double value, Widget? child) {
          return Transform.translate(
              // Mover al eje X
              offset: (axis == Axis.horizontal)
                  ? Offset(value * offset, 0.0)
                  : Offset(0.0, value * offset),
              child: child);
        });
  }
}
