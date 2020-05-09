import 'package:flutter/material.dart';

/* ---------------------- Cuadrado ---------------------- */
class HeaderCuadrado extends StatelessWidget {
  const HeaderCuadrado({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 300, color: Color(0xff615AAB));
  }
}

/* Con gradiente */
class HeaderCuadradoGradiente extends StatefulWidget {
  HeaderCuadradoGradiente({Key key}) : super(key: key);

  @override
  _HeaderCuadradoGradienteState createState() =>
      _HeaderCuadradoGradienteState();
}

class _HeaderCuadradoGradienteState extends State<HeaderCuadradoGradiente> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final gradiente = Container(
      width: double.infinity,
      height: size.height * 0.5,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              /* begin: FractionalOffset(0.0, 0.6),
              end: FractionalOffset(0.0, 1.0), */
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.blue, Colors.white])),
    );

    return Stack(
      children: <Widget>[gradiente],
    );
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
  final Color color;

  const HeaderWave({Key key, @required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(painter: _HeaderWavePainter(this.color)),
    );
  }
}

class _HeaderWavePainter extends CustomPainter {
  final Color color;

  _HeaderWavePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    // Coordenadas y dibujos
    final paint = Paint(); // Lápiz para dibujar
    // Propiedades
    paint.color = this.color;
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

/* Cabecera con ícono */
class IconHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color colorGradient1;
  final Color colorGradient2;

  const IconHeader(
      {Key key,
      @required this.icon,
      @required this.title,
      @required this.subtitle,
      this.colorGradient1 = Colors.grey,
      this.colorGradient2 = Colors.blueGrey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color colorBlanco = Colors.white.withOpacity(0.7);

    return Stack(
      children: <Widget>[
        _IconHeaderBackground(
            colorGradient1: this.colorGradient1,
            colorGradient2: this.colorGradient2),
        Positioned(
            top: -50.0,
            left: -70.0,
            child: Icon(this.icon,
                size: 250.0, color: Colors.white.withOpacity(0.2))),
        Column(
          children: <Widget>[
            SizedBox(height: 80.0, width: double.infinity),
            Text(
              this.subtitle,
              style: TextStyle(fontSize: 20.0, color: colorBlanco),
            ),
            SizedBox(height: 20.0),
            Text(
              this.title,
              style: TextStyle(
                  fontSize: 25.0,
                  color: colorBlanco,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Icon(this.icon, size: 80.0, color: Colors.white)
          ],
        )
      ],
    );
  }
}

class _IconHeaderBackground extends StatelessWidget {
  final Color colorGradient1;
  final Color colorGradient2;

  const _IconHeaderBackground(
      {Key key, @required this.colorGradient1, @required this.colorGradient2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 257.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80.0)),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[this.colorGradient1, this.colorGradient2])),
    );
  }
}
