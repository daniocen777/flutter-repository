import 'package:flutter/material.dart';

class AnimacionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
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

class _CuadradoAnimadoState extends State<CuadradoAnimado> {
  @override
  Widget build(BuildContext context) {
    return _Cuadrado();
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
