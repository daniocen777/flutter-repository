import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/src/helpers/helpers.dart';
import 'package:shoes_app/src/models/zapato_model.dart';
import 'package:shoes_app/src/widgets/custom_widgets.dart';
import 'package:shoes_app/src/widgets/boton_naranja.dart';

class ZapataDescPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    cambiarStatusLight();
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Hero(
                        tag: 'zapato_1',
                        child: ZapatoSizePreview(fullScreen: true)),
                    Positioned(
                      top: 80.0,
                      child: FloatingActionButton(
                        child: Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 50.0,
                        ),
                        onPressed: () {
                          cambiarStatusDark();
                          Navigator.pop(context);
                        },
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                        highlightElevation: 0.0,
                      ),
                    )
                  ],
                ),
                ZapatoDescripcion(
                    title: 'Nike Air Max 720',
                    descript:
                        "The Nike Air Max 720 goes bigger than ever before with Nike's taller Air unit yet, offering more air underfoot for unimaginable, all-day comfort. Has Air Max gone too far? We hope so."),
                /* Monto - comprar */
                _MontoYComprar(),
                _ColoresYMas(),
                _BotonesLikeCartSettings(),
                SizedBox(height: 20.0)
              ],
            ),
          ),
        )
      ],
    ));
  }
}

class _BotonesLikeCartSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      padding: EdgeInsets.symmetric(horizontal: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _BotonSombreado(
            icon: Icon(Icons.star, color: Colors.red, size: 25.0),
          ),
          _BotonSombreado(
            icon: Icon(Icons.add_shopping_cart,
                color: Colors.grey.withOpacity(0.4), size: 25.0),
          ),
          _BotonSombreado(
            icon: Icon(Icons.settings,
                color: Colors.grey.withOpacity(0.4), size: 25.0),
          ),
        ],
      ),
    );
  }
}

class _BotonSombreado extends StatelessWidget {
  final Icon icon;

  const _BotonSombreado({
    Key key,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  spreadRadius: -5.0,
                  blurRadius: 20.0,
                  offset: Offset(0.0, 10.0))
            ]),
        child: this.icon);
  }
}

class _ColoresYMas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                Positioned(
                    left: 75.0,
                    child: _BotonColor(
                        color: Color(0xff364D56),
                        index: 4,
                        imageUrl: 'assets/imgs/negro.png')),
                Positioned(
                    left: 50.0,
                    child: _BotonColor(
                        color: Color(0xff2099F1),
                        index: 3,
                        imageUrl: 'assets/imgs/azul.png')),
                Positioned(
                    left: 25.0,
                    child: _BotonColor(
                        color: Color(0xffFFAD29),
                        index: 2,
                        imageUrl: 'assets/imgs/amarillo.png')),
                _BotonColor(
                    color: Color(0xffC6D642),
                    index: 1,
                    imageUrl: 'assets/imgs/verde.png')
              ],
            ),
          ),
          /* Spacer(), */
          BotonNaranja(
            texto: 'More related items',
            alto: 30.0,
            ancho: 160.0,
            color: Color(0xffFFC675),
          )
        ],
      ),
    );
  }
}

class _BotonColor extends StatelessWidget {
  final Color color;
  final int index;
  final String imageUrl;

  const _BotonColor({
    Key key,
    this.color,
    this.index,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      delay: Duration(milliseconds: this.index * 100),
      duration: Duration(milliseconds: 300),
      child: GestureDetector(
        onTap: () {
          final zapatoModel = Provider.of<ZapatoModel>(context, listen: false);
          zapatoModel.assetimage = this.imageUrl;
        },
        child: Container(
          width: 35.0,
          height: 35.0,
          decoration: BoxDecoration(color: this.color, shape: BoxShape.circle),
        ),
      ),
    );
  }
}

class _MontoYComprar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: Row(
          children: <Widget>[
            Text(
              '\$ 180.0',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Bounce(
              delay: Duration(milliseconds: 1000),
              from: 8.0,
              child: BotonNaranja(
                texto: 'Buy now',
                ancho: 110.0,
                alto: 40.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
