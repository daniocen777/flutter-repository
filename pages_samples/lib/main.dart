import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:pages_samples/buttons/snake_button.dart';
import 'package:pages_samples/buttons/shiny_button.dart';
import 'package:pages_samples/responsive_cards/responsive_card.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  onButtonTap(Widget page) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => page));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Samples"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            MyMenuButton(
              title: "Botón brillante",
              actionTap: () {
                onButtonTap(MainShinyButtons());
              },
            ),
            MyMenuButton(
              title: "Botón serpiendte",
              actionTap: () {
                onButtonTap(MainSnakeButtons());
              },
            ),
            MyMenuButton(
              title: "Responsive cards",
              actionTap: () {
                onButtonTap(ResponsiveCards());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyMenuButton extends StatelessWidget {
  final String title;
  final VoidCallback actionTap;

  MyMenuButton({this.title, this.actionTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: MaterialButton(
        height: 50.0,
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: new Text(title),
        onPressed: actionTap,
      ),
    );
  }
}
