import 'package:flutter/material.dart';
import 'package:telegramchatapp/Pages/AccountSettingsPage.dart';

class HomePageHeader extends StatelessWidget {
  final String cade;

  const HomePageHeader({Key key, this.cade}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: AppBar(
      // Remover el botón de regreso
      automaticallyImplyLeading: false,
      backgroundColor: Colors.lightBlue,
      title: Container(
          margin: EdgeInsets.only(bottom: 4.0),
          child: TextFormField(
            style: TextStyle(fontSize: 15.0, color: Colors.white),
            /* controller: this.textEditingController, */
          )),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.settings, size: 25.0, color: Colors.white),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Settings()));
          },
        )
      ],
    ));
  }
}
