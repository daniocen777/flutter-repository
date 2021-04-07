import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:mytelegram/pages/ChattingPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/user.dart';
import '../utils/colors.dart';
import '../widgets/ProgressWidget.dart';
import '../pages/AccountSettingsPage.dart';

class HomeScreen extends StatefulWidget {
  final String? currentUserId;

  const HomeScreen({Key? key, this.currentUserId}) : super(key: key);
  @override
  State createState() => HomeScreenState(currentUserId: this.currentUserId);
}

class HomeScreenState extends State<HomeScreen> {
  final String? currentUserId;
  final textEditingController = TextEditingController();
  Future<QuerySnapshot>? futureSearchResults;

  SharedPreferences? _preferences;

  HomeScreenState({this.currentUserId});

  @override
  void initState() {
    super.initState();

    this.initMessaging();
    this.futureSearchResults =
        FirebaseFirestore.instance.collection('users').get();
  }

  @override
  void dispose() {
    this.textEditingController.dispose();
    super.dispose();
  }

  void initMessaging() async {
    var message = await FirebaseMessaging.instance.getInitialMessage();
    this._preferences = await SharedPreferences.getInstance();
    if (message != null) {
      String? id = this._preferences!.getString('id');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen(
                    currentUserId: id,
                  )));
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      /* RemoteNotification notification = message.notification!; */
      /* if (notification.body != null) {
        Fluttertoast.showToast(msg: 'Tienes un Nuevo mensaje *********');
      } */
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Fluttertoast.showToast(msg: 'Tienes un nuevo mensaje');
    });
  }

  void _emptyTextFormField() {
    this.textEditingController.clear();
  }

  Widget _appbarHeader() {
    return Container(
        child: AppBar(
      // Remover el botón de regreso
      automaticallyImplyLeading: false,
      backgroundColor: primaryColor,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.settings, size: 25.0, color: Colors.white),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => AccountSettings()));
          },
        )
      ],
      title: Container(
          margin: EdgeInsets.only(bottom: 4.0),
          child: TextFormField(
            controller: this.textEditingController,
            style: TextStyle(fontSize: 15.0, color: Colors.white),
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
                suffix: IconButton(
                    icon: Icon(Icons.clear, color: Colors.white),
                    onPressed: _emptyTextFormField)),
            onFieldSubmitted: _controlSearching,
          )),
    ));
  }

  void _controlSearching(String username) {
    Future<QuerySnapshot> allFoundUsers = FirebaseFirestore.instance
        .collection('users')
        .where('nickname', isGreaterThanOrEqualTo: username)
        .get();

    setState(() {
      this.futureSearchResults = allFoundUsers;
    });
  }

  Widget displayNoSearchResultScreen() {
    /* final Orientation orientation = MediaQuery.of(context).orientation; */
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            WebsafeSvg.asset('assets/images/team.svg',
                color: primaryColor, width: 140.0, height: 140.0),
            Text(
              'Buscar usuarios',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  Widget displayUserFoundScreen() {
    return FutureBuilder(
      future: this.futureSearchResults,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressWidget();
        }

        List<UserResult> searchUserResult = [];
        snapshot.data!.docs.forEach((element) {
          User user = User.fromDocument(element);
          UserResult userResult = UserResult(user: user);

          if (currentUserId != element['id']) {
            searchUserResult.add(userResult);
          }
        });

        return ListView(children: searchUserResult);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0), child: _appbarHeader()),
      body: (this.futureSearchResults == null)
          ? displayNoSearchResultScreen()
          : displayUserFoundScreen(),
    );
  }
}

class UserResult extends StatelessWidget {
  final User? user;

  const UserResult({Key? key, this.user}) : super(key: key);

  void sendUserToChatPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => Chat(
                  receiverId: this.user!.id,
                  receiverAvatar: this.user!.photoUrl,
                  receiverName: this.user!.nickname,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            GestureDetector(
              onTap: () => sendUserToChatPage(context),
              child: ListTile(
                leading: CircleAvatar(
                    backgroundColor: Colors.black54,
                    backgroundImage: NetworkImage(user!.photoUrl!)),
                title: Text(
                  user!.nickname,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700),
                ),
                subtitle: Text(
                  'Agregado el: ' +
                      DateFormat('dd MMMM, yyyy - hh:mm:aa').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse(user!.createdAt))),
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13.0,
                      fontStyle: FontStyle.italic),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
