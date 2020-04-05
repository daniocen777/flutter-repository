import 'package:flutter/material.dart';

/* ---------------------- Cuadrado ---------------------- */
class HeaderCuadrado extends StatelessWidget {
  const HeaderCuadrado({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 300, color: Color(0xff615AAB));
  }
}

/* ---------------------- Redondeado ---------------------- */
class HeaderBordesRedondeado extends StatelessWidget {
  const HeaderBordesRedondeado({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          color: Color(0xff615AAB),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(70),
            bottomRight: Radius.circular(70),
          )),
    );
  }
}

/* ---------------------- Diagonal ---------------------- */
class HeaderDiagonal extends StatelessWidget {
  const HeaderDiagonal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderDiagonalPainter(),
      ),
    );
  }
}

class _HeaderDiagonalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Coordenadas y dibujos
    final paint = Paint(); // Lápiz para dibujar
    // Propiedades
    paint.color = Color(0xff615AAB);
    // fill => pintado stroke => línea
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 5.0;

    final path = new Path();
    // Dibujar con el pat y el lápiz (0.0 => extremo izquierdo)
    path.moveTo(0, size.height * 0.35);
    path.lineTo(size.width, size.height * 0.30); // Línea
    path.lineTo(size.width, 0.0); // Línea
    path.lineTo(0.0, 0.0); // Línea

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

/* ---------------------- Triangular ---------------------- */
class HeaderTriangular extends StatelessWidget {
  const HeaderTriangular({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderTriangularPainter(),
      ),
    );
  }
}

class _HeaderTriangularPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Coordenadas y dibujos
    final paint = Paint(); // Lápiz para dibujar
    // Propiedades
    paint.color = Color(0xff615AAB);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 5.0;

    final path = new Path();
    // Dibujar con el pat y el lápiz (0.0 => extremo izquierdo)
    // ----- Pintando la parte de arriba -----
    path.lineTo(size.width, size.height); // Línea
    path.lineTo(size.width, 0.0);

    // ----- Pintando la parte de abajo -----
    /*  path.lineTo(0.0, size.height);
    path.lineTo(0.0, 0.0); */

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

/* ---------------------- Pico ---------------------- */
class HeaderPico extends StatelessWidget {
  const HeaderPico({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderPicoPainter(),
      ),
    );
  }
}

class _HeaderPicoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Coordenadas y dibujos
    final paint = Paint(); // Lápiz para dibujar
    // Propiedades
    paint.color = Color(0xff615AAB);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 5.0;

    final path = new Path();
    // Dibujar con el pat y el lápiz (0.0 => extremo izquierdo)
    // ----- Pintando la parte de arriba -----
    path.lineTo(0.0, size.height * 0.20);
    path.lineTo(size.width * 0.5, size.height * 0.28);
    path.lineTo(size.width, size.height * 0.20);
    path.lineTo(size.width, 0.0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

/* ---------------------- Curvo ---------------------- */
class HeaderCurvo extends StatelessWidget {
  const HeaderCurvo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderCurvoPainter(),
      ),
    );
  }
}

class _HeaderCurvoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Coordenadas y dibujos
    final paint = Paint(); // Lápiz para dibujar
    // Propiedades
    paint.color = Color(0xff615AAB);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 5.0;

    final path = new Path();
    path.lineTo(0.0, size.height * 0.25);
    //quadraticBezierTo(X-ángulo_curvatura,Y-ángulo_curvatura, X-final, Y-final )
    // ángulo_curvatura => por dónde debe pasar la curva
    path.quadraticBezierTo(
        size.width * 0.50, size.height * 0.40, size.width, size.height * 0.25);

    path.lineTo(size.width, 0.0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

/* ---------------------- Wave => doble curva, como una ola ---------------------- */
class HeaderWave extends StatelessWidget {
  const HeaderWave({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderWavePainter(),
      ),
    );
  }
}

class _HeaderWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Coordenadas y dibujos
    final paint = Paint(); // Lápiz para dibujar
    // Propiedades
    paint.color = Color(0xff615AAB);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 5.0;

    final path = new Path();
    path.lineTo(0.0, size.height * 0.25);
    //quadraticBezierTo(X-ángulo_curvatura,Y-ángulo_curvatura, X-final, Y-final )
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.30,
        size.width * 0.50, size.height * 0.25);

    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.20, size.width, size.height * 0.25);

    path.lineTo(size.width, 0.0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
