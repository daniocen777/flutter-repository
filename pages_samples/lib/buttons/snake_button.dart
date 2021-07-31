import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class MainSnakeButtons extends StatelessWidget {
  const MainSnakeButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Snake Button'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SnakeButton(
                child: Text(
                  'Holas mundos',
                ),
                onTap: () => print('Botón serpiente'),
              ),
              const SizedBox(
                height: 25.0,
              ),
              _SnakeButton(
                snakeColor: Colors.red,
                borderWidth: 3.0,
                duration: const Duration(milliseconds: 3000),
                child: Text(
                  'Botón serpiente 2',
                ),
                onTap: () => print('Botón serpiente 2'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SnakeButton extends StatefulWidget {
  final Widget? child;
  final Duration? duration;
  final Color snakeColor;
  final Color borderColor;
  final double borderWidth;
  final VoidCallback? onTap;

  _SnakeButton(
      {Key? key,
      this.child,
      this.duration,
      this.snakeColor = Colors.purple,
      this.borderColor = Colors.white,
      this.borderWidth = 6.0,
      this.onTap})
      : super(key: key);

  @override
  __SnakeButtonState createState() => __SnakeButtonState();
}

class __SnakeButtonState extends State<_SnakeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: widget.duration ?? Duration(milliseconds: 1500));

    _controller.repeat();
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
      child: CustomPaint(
        painter: _SnakePainter(
            animation: _controller,
            borderColor: widget.borderColor,
            borderWidth: widget.borderWidth,
            snakeColor: widget.snakeColor),
        child: Container(
          alignment: Alignment.center,
          child: Padding(padding: EdgeInsets.all(15.0), child: widget.child),
        ),
      ),
    );
  }
}

/* Clase para custom Painter */
class _SnakePainter extends CustomPainter {
  final Animation animation;
  final Color? snakeColor;
  final Color? borderColor;
  final double? borderWidth;

  _SnakePainter({
    required this.animation,
    this.snakeColor,
    this.borderColor,
    this.borderWidth,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    // Path

    final paint = Paint()
      ..shader = SweepGradient(
              colors: [snakeColor!, Colors.transparent],
              stops: [0.6, 1.0],
              startAngle: 0.0,
              endAngle: vector.radians(80),
              transform:
                  GradientRotation(vector.radians(360.0 * animation.value)))
          .createShader(rect);

    final path = Path.combine(PathOperation.xor, Path()..addRect(rect),
        Path()..addRect(rect.deflate(borderWidth!)));
    // Borde el botón
    canvas.drawRect(
        rect.deflate(borderWidth! / 2),
        Paint()
          ..color = borderColor!
          ..strokeWidth = borderWidth!
          ..style = PaintingStyle.stroke);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw UnimplementedError();
  }
}
