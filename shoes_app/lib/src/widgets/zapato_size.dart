import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/src/models/zapato_model.dart';
import 'package:shoes_app/src/pages/zapato_desc_page.dart';

class ZapatoSizePreview extends StatelessWidget {
  final bool fullScreen;

  ZapatoSizePreview({this.fullScreen = false});

  @override
  Widget build(BuildContext context) {
    if (fullScreen) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: Container(
          width: double.infinity,
          /* height: 400.0, */
          decoration: BoxDecoration(
              color: Color(0xffFFCF53),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0))),
          child: Column(
            children: <Widget>[
              // Zapato con sombra
              _ZapatoConSombra(),
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ZapataDescPage()));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color(0xffFFCF53),
                borderRadius: BorderRadius.circular(50.0)),
            child: Column(
              children: <Widget>[
                // Zapato con sombra
                _ZapatoConSombra(),
                // Tallas Zapato
                if (!this.fullScreen)
                  _ZapatoTallas(),
                SizedBox(
                  height: 20.0,
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}

class _ZapatoConSombra extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final zapatoModel = Provider.of<ZapatoModel>(context);
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Stack(
        children: <Widget>[
          /* Positioned(bottom: 10.0, right: -50.0, child: _ZapatoSombra()), */
          Image(image: AssetImage(zapatoModel.assetimage))
        ],
      ),
    );
  }
}

/* class _ZapatoSombra extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.5,
      child: Container(
        width: 230.0,
        height: 100.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            boxShadow: [BoxShadow(color: Color(0xffEAA14E), blurRadius: 40.0)]),
      ),
    );
  }
} */

class _ZapatoTallas extends StatelessWidget {
  const _ZapatoTallas({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _TallaZapatoCaja(
            numero: 7.0,
          ),
          _TallaZapatoCaja(
            numero: 7.5,
          ),
          _TallaZapatoCaja(
            numero: 8.0,
          ),
          _TallaZapatoCaja(
            numero: 8.5,
          ),
          _TallaZapatoCaja(
            numero: 9.0,
          ),
          _TallaZapatoCaja(
            numero: 9.5,
          )
        ],
      ),
    );
  }
}

class _TallaZapatoCaja extends StatelessWidget {
  final double numero;

  const _TallaZapatoCaja({Key key, this.numero}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final zapatoModel = Provider.of<ZapatoModel>(context);

    return GestureDetector(
      onTap: () {
        final zapatoModel = Provider.of<ZapatoModel>(context, listen: false);
        zapatoModel.talla = this.numero;
      },
      child: Container(
          width: 38.0,
          height: 38.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: (this.numero == zapatoModel.talla)
                  ? Color(0xffF1A23A)
                  : Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                if (this.numero == zapatoModel.talla)
                  BoxShadow(
                    color: Color(0xffF1A23A),
                    blurRadius: 10.0,
                    offset: Offset(0, 5),
                  )
              ]),
          child: Text('${numero.toString().replaceAll(".0", "")}',
              style: TextStyle(
                  color: (this.numero == zapatoModel.talla)
                      ? Colors.white
                      : Color(0xffF1A23A),
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold))),
    );
  }
}
