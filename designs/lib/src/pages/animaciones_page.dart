import 'package:flutter/material.dart';
import 'dart:math' as Math;

class AnimacionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(child: CuadradoAnimado()),
      ),
    );
  }
}

/* Animación */
class CuadradoAnimado extends StatefulWidget {
  const CuadradoAnimado({
    Key key,
  }) : super(key: key);

  @override
  _CuadradoAnimadoState createState() => _CuadradoAnimadoState();
}

class _CuadradoAnimadoState extends State<CuadradoAnimado>
    with SingleTickerProviderStateMixin {
  // 2 cosas para para animar (Animation<tipo> y AnimationController)
  /* with SingleTickerProviderStateMixin  */
  AnimationController controller;
  Animation<double> rotacion;

  Animation<double> opacidad;
  Animation<double> opacidadOut;

  Animation<double> moverDerecha;
  Animation<double> agrandar;

  // Inicializar los dos objetos
  @override
  void initState() {
    controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 4000));
    /* rotacion = Tween(begin: 0.0, end: 2.0 * Math.pi).animate(controller); */
    /*  ---- Easings => https://easings.net/ ---- */
    rotacion = Tween(begin: 0.0, end: 2.0 * Math.pi)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    // Interval (inicio, final[% de 4000], curve)
    opacidad = Tween(begin: 0.1, end: 1.0).animate(CurvedAnimation(
        parent: controller, curve: Interval(0, 0.25, curve: Curves.easeOut)));

    opacidadOut = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.75, 1.0, curve: Curves.easeOut)));

    // moverDerecha = Tween(begin: 0.0, end: 200.0).animate(controller);
    moverDerecha = Tween(begin: 0.0, end: 200.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    agrandar = Tween(begin: 0.0, end: 2.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    // Acá se colocan los listener
    controller.addListener(() {
      if (controller.status == AnimationStatus.completed) {
        // controller.reverse();
        controller.reset();
      }
      /* else if (controller.status == AnimationStatus.dismissed) {
        controller.forward();
      } */
      /* print('status: ${controller.status}'); */
    });

    super.initState();
  }

  // Cerrar
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Play / Reproduce animación
    controller.forward();
    return AnimatedBuilder(
      animation: controller,
      child: _Cuadrado(),
      builder: (BuildContext context, Widget childCuadrado) {
        return Transform.translate(
          // Offset(mover-x, mover-y)
          offset: Offset(moverDerecha.value, 0),
          child: Transform.rotate(
              angle: rotacion.value,
              child: Opacity(
                  opacity: opacidad.value - opacidadOut.value,
                  child: Transform.scale(
                      scale: agrandar.value, child: childCuadrado))),
        );
      },
    );
  }
}

/* Cuadrado */
class _Cuadrado extends StatelessWidget {
  const _Cuadrado({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(color: Colors.blueAccent),
    );
  }
}
