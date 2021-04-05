import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mytelegram/pages/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colors.dart';
import '../widgets/ProgressWidget.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  SharedPreferences? _preferences;
  bool isLoggedIn = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    this.isSignedIn();
  }

  void isSignedIn() async {
    setState(() {
      this.isLoading = true;
    });
    this._preferences = await SharedPreferences.getInstance();
    bool isLoggedIn = await this._googleSignIn.isSignedIn();
    if (isLoggedIn) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  HomeScreen(currentUserId: _preferences!.getString('id'))));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: <Color>[primaryColor, secondColorLight])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Chat Privado',
                style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                    fontFamily: 'Signatra')),
            GestureDetector(
              onTap: controlSignIn,
              child: Center(
                  child: Column(
                children: [
                  Container(
                    width: 270.0,
                    height: 65.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/google_signin_button.png'),
                            fit: BoxFit.cover)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child:
                        this.isLoading ? CircularProgressWidget() : Container(),
                  )
                ],
              )),
            )
          ],
        ),
      ),
    );
  }

  Future<void> controlSignIn() async {
    this._preferences = await SharedPreferences.getInstance();

    setState(() {
      this.isLoading = true;
    });

    GoogleSignInAccount? googleUser = await this._googleSignIn.signIn();
    GoogleSignInAuthentication googleAuthentication =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken);

    final firebaseUser =
        (await this._firebaseAuth.signInWithCredential(credential)).user;

    // Firestore colección
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    if (firebaseUser != null) {
      // Check si está registrado en firebase
      final QuerySnapshot resultQuery =
          await usersCollection.where('id', isEqualTo: firebaseUser.uid).get();

      final List<DocumentSnapshot> documentSnapshots = resultQuery.docs;
      // Si no existen datos, crearlos la colección en Firestore
      if (documentSnapshots.length == 0) {
        usersCollection.doc(firebaseUser.uid).set({
          'nickname': firebaseUser.displayName,
          'photoUrl': firebaseUser.photoURL,
          'id': firebaseUser.uid,
          'aboutMe': 'Usando el chat privado',
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
          'chattingWith': null,
        });
        // Luego, escribir los datos en local
        final currentUser = firebaseUser;
        await this._preferences!.setString('id', currentUser.uid);
        await this
            ._preferences!
            .setString('nickname', currentUser.displayName!);
        await this._preferences!.setString('photoUrl', currentUser.photoURL!);
      } else {
        // Guardar los otros datos
        await this._preferences!.setString('id', documentSnapshots[0]['id']);
        await this
            ._preferences!
            .setString('nickname', documentSnapshots[0]['nickname']);
        await this
            ._preferences!
            .setString('photoUrl', documentSnapshots[0]['photoUrl']);
        await this
            ._preferences!
            .setString('aboutMe', documentSnapshots[0]['aboutMe']);
      }
      Fluttertoast.showToast(msg: 'Autenticación correcta');
      setState(() {
        this.isLoading = false;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  HomeScreen(currentUserId: firebaseUser.uid)));
    } else {
      Fluttertoast.showToast(
          msg: 'Fallo de autenticación, intenta una vez más');
      setState(() {
        this.isLoading = false;
      });
    }
  }
}
