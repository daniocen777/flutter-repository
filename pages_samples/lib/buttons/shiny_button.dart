/* Botón brillante */

import 'package:flutter/material.dart';

class MainShinyButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shiny Buttons'),
      ),
      body: Padding(
        padding: EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ShinyButton(
              child:
                  Text('Holas mundos', style: TextStyle(color: Colors.black87)),
              color: Colors.red,
              onTap: () => print('Shiny Button RED'),
            ),
            const SizedBox(
              height: 20.0,
            ),
            _ShinyButton(
              child: Text('Botón azul', style: TextStyle(color: Colors.white)),
              color: Colors.indigo[900]!,
              onTap: () => print('Shiny Button RED'),
            )
          ],
        ),
      ),
    );
  }
}

class _ShinyButton extends StatefulWidget {
  final Widget child;
  final Color? color;
  final VoidCallback? onTap;

  _ShinyButton({Key? key, required this.child, this.color, this.onTap})
      : super(key: key);

  @override
  __ShinyButtonState createState() => __ShinyButtonState();
}

class __ShinyButtonState extends State<_ShinyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onTap,
        child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              return Container(
                  padding: EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  child: widget.child,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                        widget.color!,
                        Colors.white,
                        widget.color!
                      ],
                          stops: [
                        0.0,
                        // El valor del medio es el que debe cambiar para realizar el efecto
                        _controller.value,
                        1.0
                      ])));
            }));
  }
}
