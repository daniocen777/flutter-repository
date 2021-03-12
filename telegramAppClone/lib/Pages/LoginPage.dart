import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telegramchatapp/Pages/HomePage.dart';
import 'package:telegramchatapp/Widgets/ProgressWidget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telegramchatapp/utils/responsive.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  SharedPreferences _preferences;
  bool isLoggedIn = false;
  bool isLoading = false;
  FirebaseUser _firebaseUser;

  @override
  void initState() {
    super.initState();
    this.isSignedIn();
  }

  void isSignedIn() async {
    setState(() {
      isLoading = true;
    });
    _preferences = await SharedPreferences.getInstance();
    isLoggedIn = await _googleSignIn.isSignedIn();
    if (isLoggedIn) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  HomeScreen(currentUserId: _preferences.getString('id'))));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _responsive = new Responsive.of(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: <Color>[Colors.lightBlueAccent, Colors.purpleAccent])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Dani Chat',
                style: TextStyle(
                    fontSize: _responsive.ip(8.5),
                    color: Colors.white,
                    fontFamily: 'Signatra')),
            GestureDetector(
              onTap: handleSignIn,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: 250.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/google_signin_button.png'),
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: this.isLoading
                          ? CircularProgressWidget()
                          : Container(),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> handleSignIn() async {
    this._preferences = await SharedPreferences.getInstance();
    setState(() {
      this.isLoading = true;
    });
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    FirebaseUser firebaseUser =
        (await _firebaseAuth.signInWithCredential(credential)).user;
    if (firebaseUser != null) {
      // Check si usuario está registrado
      final QuerySnapshot resultQuery = await Firestore.instance
          .collection('users')
          .where('id', isEqualTo: firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> documentSnapshot = resultQuery.documents;
      // Si no existe usuario, guardar sus datos y crear nuevo usuario
      if (documentSnapshot.length == 0) {
        Firestore.instance
            .collection('users')
            .document(firebaseUser.uid)
            .setData({
          'nickname': firebaseUser.displayName,
          'photoUrl': firebaseUser.photoUrl,
          'id': firebaseUser.uid,
          'aboutMe': 'Estoy usando la aplicación DaniChat',
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
          'chattingWith': null
        });
        // Colocarlo en preferencias
        _firebaseUser = firebaseUser;
        await _preferences.setString('id', _firebaseUser.uid);
        await _preferences.setString('nickname', _firebaseUser.displayName);
        await _preferences.setString('photoUrl', _firebaseUser.photoUrl);
      } else {
        _firebaseUser = firebaseUser;
        await _preferences.setString('id', documentSnapshot[0]['id']);
        await _preferences.setString(
            'nickname', documentSnapshot[0]['nickname']);
        await _preferences.setString(
            'photoUrl', documentSnapshot[0]['photoUrl']);
        await _preferences.setString('aboutMe', documentSnapshot[0]['aboutMe']);
      }
      Fluttertoast.showToast(msg: 'Credenciales correctas');
      setState(() {
        this.isLoading = false;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  HomeScreen(currentUserId: _firebaseUser.uid)));
    } else {
      Fluttertoast.showToast(msg: 'Error de conexión, Intenta de nuevo');
      setState(() {
        this.isLoading = false;
      });
    }
  }
}
