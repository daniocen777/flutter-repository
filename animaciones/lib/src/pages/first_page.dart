import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FirstPage extends StatefulWidget {
  FirstPage({Key key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FadeIn(child: Text("Splash animate")),
        actions: <Widget>[
          IconButton(
              icon: FaIcon(FontAwesomeIcons.twitter),
              onPressed: () {
                Navigator.of(context).pushNamed("/splash");
              }),
          SlideInLeft(
            from: 50.0,
            child: IconButton(
                icon: Icon(
                  Icons.navigate_next,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed("/");
                }),
          ),
        ],
      ),
      floatingActionButton: ElasticInRight(
        child: FloatingActionButton(
            child: FaIcon(FontAwesomeIcons.play), onPressed: () {}),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElasticIn(
              delay: Duration(milliseconds: 1100),
              child: Icon(
                Icons.new_releases,
                color: Colors.blue,
                size: 40.0,
              ),
            ),
            FadeInDown(
              delay: Duration(milliseconds: 200),
              child: Text(
                "Título",
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w200),
              ),
            ),
            FadeInDown(
              delay: Duration(milliseconds: 800),
              child: Text(
                "Texto pequeño",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w200),
              ),
            ),
            FadeInLeft(
                delay: Duration(milliseconds: 1100),
                child: Container(
                    width: 220.0, height: 2.0, color: Colors.blueAccent)),
            FadeInLeft(
                delay: Duration(milliseconds: 1100),
                child: RaisedButton(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                    child: Text("Ir a Navegación",
                        style: TextStyle(color: Colors.white)),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  elevation: 1.0,
                  color: Colors.deepOrange,
                  textColor: Colors.white,
                  onPressed: () => Navigator.of(context).pushNamed("/nav"),
                )),
          ],
        ),
      ),
    );
  }
}
