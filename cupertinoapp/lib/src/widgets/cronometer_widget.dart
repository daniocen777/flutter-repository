import 'dart:async';

import 'package:cupertinoapp/src/widgets/circle-container_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

/* Usando after_layout => Mostrar un wigget juesto después de renderizar el build */
class Cronometer extends StatefulWidget {
  final double initTime;
  final double fontSize;

  Cronometer({Key key, this.initTime = 0.0, this.fontSize = 20.0})
      : super(key: key);

  @override
  _CronometerState createState() => _CronometerState();
}

class _CronometerState extends State<Cronometer> with AfterLayoutMixin {
  double _time = 0.0;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _time = widget.initTime;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void afterFirstLayout(BuildContext context) {
   /*  showDialog(
        context: this.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Alert'),
          );
        }); */
  }

  @override
  void dispose() {
    // Liberar recursos
    _stop();
    super.dispose();
  }

  void _start() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        _time += 1;
      });
    });
  }

  void _stop() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: <Widget>[
          Text(_time.toString(), style: TextStyle(fontSize: widget.fontSize)),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoButton(
                  child: CircleContainer(
                      child: Icon(Icons.play_arrow), size: 50.0),
                  onPressed: _start),
              CupertinoButton(
                  child: CircleContainer(child: Icon(Icons.stop), size: 50.0),
                  onPressed: _stop)
            ],
          )
        ],
      ),
    );
  }
}
