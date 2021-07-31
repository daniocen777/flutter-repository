import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:pages_samples/buttons/snake_button.dart';
import 'package:pages_samples/buttons/shiny_button.dart';
import 'package:pages_samples/rappi_scroll_sync/rappi-scroll-sync_page.dart';
import 'package:pages_samples/responsive_cards/responsive_card.dart';
import 'package:pages_samples/shake_transition/shake_transition.dart';
import 'package:pages_samples/nike_shoes_store/nike_shoes_store.dart';
import 'package:pages_samples/bank_finance/main_bank_finance.dart';
import 'package:pages_samples/social_media/pages/login_page.dart';

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
        appBar: AppBar(title: Text("Flutter Samples")),
        body: Padding(
            padding: EdgeInsets.all(15.0),
            child: ListView(children: <Widget>[
              MyMenuButton(
                  title: "Botón brillante",
                  actionTap: () {
                    onButtonTap(MainShinyButtons());
                  }),
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
                  }),
              MyMenuButton(
                  title: "Transición animada",
                  actionTap: () {
                    onButtonTap(MainShakeTransition());
                  }),
              MyMenuButton(
                  title: "Página Zapatos Nike",
                  actionTap: () {
                    onButtonTap(MainNikeShoesStore());
                  }),
              MyMenuButton(
                  title: "Rappi Scroll sincronizado",
                  actionTap: () {
                    onButtonTap(RappiScrollSyncPage());
                  }),
              MyMenuButton(
                  title: "Bank and Finance",
                  actionTap: () {
                    onButtonTap(MainBankFinancePage());
                  }),
              MyMenuButton(
                  title: "Red Social",
                  actionTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginPage()));
                  })
            ])));
  }
}

class MyMenuButton extends StatelessWidget {
  final String? title;
  final VoidCallback? actionTap;

  MyMenuButton({this.title, this.actionTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: MaterialButton(
        height: 50.0,
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: new Text(title!),
        onPressed: actionTap,
      ),
    );
  }
}
