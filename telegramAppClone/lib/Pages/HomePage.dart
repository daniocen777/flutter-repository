import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:telegramchatapp/Pages/ChattingPage.dart';
import 'package:telegramchatapp/Pages/LoginPage.dart';
import 'package:telegramchatapp/Widgets/home_header.dart';
import 'package:telegramchatapp/main.dart';
import 'package:telegramchatapp/models/user.dart';
import 'package:telegramchatapp/Pages/AccountSettingsPage.dart';
import 'package:telegramchatapp/Widgets/ProgressWidget.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  final String currentUserId;

  const HomeScreen({Key key, this.currentUserId}) : super(key: key);

  @override
  State createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final TextEditingController searchTextEditingController =
      TextEditingController();
  final String cade = '';

  void emptyTextFormField() {
    searchTextEditingController.clear();
  }

  Widget homePageHeader() {
    return Container(
        child: AppBar(
      // Remover el botón de regreso
      automaticallyImplyLeading: false,
      backgroundColor: Colors.lightBlue,
      title: Container(
          margin: EdgeInsets.only(bottom: 4.0),
          child: TextFormField(
            style: TextStyle(fontSize: 15.0, color: Colors.white),
            controller: this.searchTextEditingController,
            decoration: InputDecoration(
                hintText: 'Buscar...',
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                filled: true,
                prefixIcon: Icon(
                  Icons.person_pin,
                  color: Colors.white,
                  size: 25.0,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
                  onPressed: emptyTextFormField,
                )),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this.homePageHeader(),
      body: RaisedButton.icon(
        onPressed: logoutUser,
        icon: Icon(Icons.close),
        label: Text('Cerra sesión'),
      ),
    );
  }

  Future<void> logoutUser() async {
    await FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => MyApp()),
        (Route<dynamic> route) => false);
  }
}

class UserResult extends StatelessWidget {
  const UserResult({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {}
}
