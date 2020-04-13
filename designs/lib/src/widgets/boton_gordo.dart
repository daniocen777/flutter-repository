import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BotonGordo extends StatelessWidget {
  final IconData icon;
  final String texto;
  final Color color1;
  final Color color2;
  final Function onPress;

  const BotonGordo(
      {Key key,
      this.icon = FontAwesomeIcons.circle,
      @required this.texto,
      this.color1 = Colors.grey,
      this.color2 = Colors.blueGrey,
      @required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPress,
      child: Stack(
        children: <Widget>[
          _BotonGordoBackground(this.icon, this.color1, this.color2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 140.0, width: 40.0),
              Icon(
                this.icon,
                size: 40.0,
                color: Colors.white,
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: Text(this.texto,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    )),
              ),
              Icon(
                FontAwesomeIcons.chevronRight,
                size: 40.0,
                color: Colors.white,
              ),
              SizedBox(width: 40.0)
            ],
          )
        ],
      ),
    );
  }
}

class _BotonGordoBackground extends StatelessWidget {
  final IconData icon;
  final Color color1;
  final Color color2;

  const _BotonGordoBackground(this.icon, this.color1, this.color2);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.0,
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Colors.red,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(4.0, 6.0),
              blurRadius: 10.0,
            ),
          ],
          borderRadius: BorderRadius.circular(15.0),
          gradient: LinearGradient(colors: <Color>[this.color1, this.color2])),
      // ClipRRect => Corta los bordes si su widget se sale de las dimensiones
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Stack(
          children: <Widget>[
            Positioned(
                right: -20.0,
                top: -20.0,
                child: Icon(
                  this.icon,
                  size: 150.0,
                  color: Colors.white.withOpacity(0.2),
                ))
          ],
        ),
      ),
    );
  }
}
