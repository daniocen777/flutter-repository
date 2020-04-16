import 'package:flutter/material.dart';

import 'package:designs/src/theme/theme.dart';
import 'package:designs/src/widgets/radial_progress.dart';
import 'package:provider/provider.dart';

class GraficasCirculares extends StatefulWidget {
  const GraficasCirculares({Key key}) : super(key: key);

  @override
  _GraficasCircularesState createState() => _GraficasCircularesState();
}

class _GraficasCircularesState extends State<GraficasCirculares> {
  double porcentaje = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                porcentaje += 10.0;
                if (porcentaje > 100) {
                  porcentaje = 0.0;
                }
              });
            }),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CustomRadialProgress(
                  porcentaje: porcentaje,
                  color: Colors.blue,
                ),
                CustomRadialProgress(
                  porcentaje: porcentaje * 1.2,
                  color: Colors.limeAccent,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CustomRadialProgress(
                  porcentaje: porcentaje * 1.4,
                  color: Colors.greenAccent,
                ),
                CustomRadialProgress(
                  porcentaje: porcentaje * 1.6,
                  color: Colors.pinkAccent,
                ),
              ],
            )
          ],
        ));
  }
}

class CustomRadialProgress extends StatelessWidget {
  final Color color;

  const CustomRadialProgress({
    Key key,
    @required this.porcentaje,
    @required this.color,
  }) : super(key: key);

  final double porcentaje;

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;
    return Container(
        width: 150,
        height: 150,
        child: RadialProgress(
          porcentaje: porcentaje,
          colorPrimario: color,
          colorBorde: appTheme.textTheme.body1.color,
          grosorBorde: 5.0,
          grosorprimario: 5.0,
        ));
  }
}
