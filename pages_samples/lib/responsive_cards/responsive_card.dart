import 'package:flutter/material.dart';

class ResponsiveCards extends StatelessWidget {
  const ResponsiveCards({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Orientation oritentation = MediaQuery.of(context).orientation;
    return Scaffold(
        backgroundColor: Color(0xff212239),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Tarjetas',
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              Expanded(
                  child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 900),
                transitionBuilder: (widget, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: widget,
                  );
                },
                child: (oritentation == Orientation.portrait)
                    ? ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: 20,
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                            child: _CardItem(
                              color: Colors
                                  .primaries[index % Colors.primaries.length],
                              precio: 143.21,
                              usuario: 'Daniel Ocean',
                              numeroTarjeta: '1233 **** **** 2443',
                            ),
                          );
                        },
                      )
                    : GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemCount: 20,
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                            child: _CardItem(
                              color: Colors
                                  .primaries[index % Colors.primaries.length],
                              precio: 143.21,
                              usuario: 'Daniel Ocean',
                              numeroTarjeta: '1233 **** **** 2443',
                            ),
                          );
                        },
                      ),
              ))
            ],
          ),
        ));
  }
}

class _CardItem extends StatelessWidget {
  final Color color;
  final double precio;
  final String numeroTarjeta;
  final String usuario;

  const _CardItem(
      {Key key, this.color, this.precio, this.numeroTarjeta, this.usuario})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: double.infinity,
        height: 160.0,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [color.withOpacity(0.3), color]),
            borderRadius: BorderRadius.circular(20.0)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('\$$precio'),
              Spacer(),
              Text('$numeroTarjeta'),
              Text('$usuario'),
            ],
          ),
        ),
      ),
    );
  }
}
