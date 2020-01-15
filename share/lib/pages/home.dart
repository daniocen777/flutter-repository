import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Import google firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:share/models/user.dart';
import 'package:share/pages/activity_feed.dart';
import 'package:share/pages/create_account.dart';
import 'package:firebase_storage/firebase_storage.dart';
// Import páginas creadas
import 'package:share/pages/profile.dart';
import 'package:share/pages/search.dart';

import 'package:share/pages/upload.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final StorageReference storageRef = FirebaseStorage.instance.ref();
final userRef = Firestore.instance.collection("users");
final postRef = Firestore.instance.collection("posts");
final DateTime timestamp = DateTime.now();
User currentUser;

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isAuth = false;
  PageController _pageController;
  int _pageIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(); // Iniciando PageController
    // Detecta cuando usuario ingresa
    googleSignIn.onCurrentUserChanged.listen((account) {
      _handleSignIn(account);
    }, onError: (err) {
      print("Error signin in: $err");
    });
    // Reautenticar cuando usuario reingresa a la app
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      _handleSignIn(account);
    }).catchError((err) {
      print("Error signin in: $err");
    });
  }

  _handleSignIn(GoogleSignInAccount account) {
    if (account != null) {
      createUserInFirestore();
      setState(() {
        _isAuth = true;
      });
    } else {
      setState(() {
        _isAuth = false;
      });
    }
  }

  createUserInFirestore() async {
    // 1 chequeando si user existe en colección
    final GoogleSignInAccount user = googleSignIn.currentUser;
    DocumentSnapshot doc = await userRef.document(user.id).get();
    if (!doc.exists) {
      // 2 Si user NO existe, crear la colección
      final username = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateAccount()));
      // 3 Traer el username de la página create_account y crear el usuario
      userRef.document(user.id).setData({
        "id": user.id,
        "username": username,
        "photoUrl": user.photoUrl,
        "email": user.email,
        "displayName": user.displayName,
        "bio": "",
        "timestamp": timestamp
      });

      doc = await userRef.document(user.id).get(); // Traer la data actual
    }

    // Seteando los datos de la colleción en el objeto
    currentUser = User.fromDocument(doc);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  login() {
    googleSignIn.signIn();
  }

  logout() {
    googleSignIn.signOut();
  }

  _onPageChanged(int pageIndex) {
    setState(() {
      this._pageIndex = pageIndex;
    });
  }

  _onTap(int pageIndex) {
    _pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  Scaffold _buildAuthScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          //Timeline(),
          RaisedButton(
            child: Text("Logout"),
            onPressed: logout,
          ),
          ActivityFeed(),
          Upload(currentUser: currentUser),
          Search(),
          Profile(profileId: currentUser?.id)
        ],
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _pageIndex,
        onTap: _onTap,
        activeColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.whatshot)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active)),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.photo_camera,
            size: 35.0,
          )),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle))
        ],
      ),
    );
  }

  _buildUnAuthScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor
            ])),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "FlutterShare",
              style: TextStyle(
                  fontFamily: "Signatra", fontSize: 90.0, color: Colors.white),
            ),
            GestureDetector(
              onTap: login,
              child: Container(
                width: 260.0,
                height: 60.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/images/google_signin_button.png"),
                        fit: BoxFit.cover)),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isAuth ? _buildAuthScreen() : _buildUnAuthScreen();
  }
}
