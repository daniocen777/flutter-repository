import 'package:flutter/material.dart';
import 'package:music_player/src/helpers/helpers.dart';
import 'package:music_player/src/widgets/custom_appbar.dart';

class MusicPalyerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        CustomAppBar(),
        Expanded(
          child: Column(
            children: <Widget>[
              _ImagenDiscoDuracion(),
              _TituloPlay(),
              Expanded(
                child: _Lyrics(),
              ),
            ],
          ),
        ),

        /* Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                _ImagenDiscoDuracion(),
                _TituloPlay(),
                Expanded(
                  child: _Lyrics(),
                ),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ), */
      ],
    ));
  }
}

class _Lyrics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lyrics = getLyrics();
    return Container(
        child: ListWheelScrollView(
      physics: BouncingScrollPhysics(),
      itemExtent: 42,
      diameterRatio: 1.5,
      children: lyrics
          .map((linea) => Text(linea,
              style: TextStyle(
                  fontSize: 15.0, color: Colors.white.withOpacity(0.6))))
          .toList(),
    ));
  }
}

class _TituloPlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      margin: EdgeInsets.only(top: 20.0),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                'Far Away',
                style: TextStyle(
                    fontSize: 25.0, color: Colors.white.withOpacity(0.8)),
              ),
              Text(
                '-Breaking Nemjamin-',
                style: TextStyle(
                    fontSize: 10.0, color: Colors.white.withOpacity(0.8)),
              )
            ],
          ),
          Spacer(),
          FloatingActionButton(
              elevation: 0.0,
              highlightElevation: 0.0,
              backgroundColor: Color(0xffF8CB51),
              child: Icon(Icons.play_arrow),
              onPressed: () {
                print('Play');
              })
        ],
      ),
    );
  }
}

class _ImagenDiscoDuracion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(top: 40.0),
      child: Row(
        children: <Widget>[
          // Disco
          _ImagenDisco(),
          Spacer(),
          // Barra de progreso
          _BarraProgreso(),
          SizedBox(width: 20.0)
        ],
      ),
    );
  }
}

class _BarraProgreso extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final estilo = TextStyle(color: Colors.white.withOpacity(0.4));
    return Container(
      child: Column(
        children: <Widget>[
          Text('00:00', style: estilo),
          SizedBox(height: 10.0),
          Stack(
            children: <Widget>[
              Container(
                width: 3.0,
                height: 100.0,
                color: Colors.white.withOpacity(0.1),
              ),
              Positioned(
                bottom: 0.0,
                child: Container(
                  width: 3.0,
                  height: 50.0,
                  color: Colors.white.withOpacity(0.8),
                ),
              )
            ],
          ),
          SizedBox(height: 10.0),
          Text('04:50', style: estilo)
        ],
      ),
    );
  }
}

class _ImagenDisco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: 180.0,
      height: 180.0,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(200.0),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/aurora.jpg'),
              ),
              Container(
                width: 25.0,
                height: 25.0,
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(100.0)),
              ),
              Container(
                width: 18.0,
                height: 18.0,
                decoration: BoxDecoration(
                    color: Color(0xff1C1C25),
                    borderRadius: BorderRadius.circular(100.0)),
              )
            ],
          )),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200.0),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: [Color(0xff484750), Color(0xff1E1C24)])),
    );
  }
}
