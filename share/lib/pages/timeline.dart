import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share/widgets/header.dart';
import 'package:share/widgets/progress.dart';

final userRef = Firestore.instance.collection("users");

class Timeline extends StatefulWidget {
  Timeline({Key key}) : super(key: key);

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  // Para getUsersFutureBuilder
  //List<dynamic> _users = [];
  @override
  void initState() {
    super.initState();
    //getUsers();
    /* getUsersFutureBuilder(); */
  }

  // Toda la data
/*   getUsers() {
    userRef.getDocuments().then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((DocumentSnapshot doc) {
        print(doc.data);
        print(doc.documentID);
        print(doc.exists); // true | false
      });
    });
  } */

  // Datos con un where
  /*  getUsersComplex() async {
    final QuerySnapshot snapshot = await userRef
        .where("postsCount", isLessThan: 3)
        .where("username", isEqualTo: "Daniel")
        .getDocuments();
    snapshot.documents.forEach((DocumentSnapshot doc) {
      print(doc.data);
      print(doc.documentID);
      print(doc.exists); // true | false
    });
  } */

  // Con FutureBuilders and StreamBuilders (LIsta)
/*   getUsersFutureBuilder() async {
    final QuerySnapshot snapshot = await userRef.getDocuments();
    setState(() {
      _users = snapshot.documents;
    });
  } */

  // Datos por id
  /*  getUserById() {
    final String id = "c3fcew";
    userRef.document(id).get().then((DocumentSnapshot doc) {
      print(doc.data);
      print(doc.documentID);
      print(doc.exists);
    });
  } */

  /* getUserById_2() async {
    final String id = "c3fcew";
    final DocumentSnapshot doc = await userRef.document(id).get();
    print(doc.data);
    print(doc.documentID);
    print(doc.exists);
  } */

  // ******************* USANDO FutureBuilder ******************* //
  /*  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header(context, isAppTitle: true),
        body: FutureBuilder<QuerySnapshot>(
          future: userRef.getDocuments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return circularProgress();
            }
            final List<Text> children = snapshot.data.documents
                .map((doc) => Text(doc["username"]))
                .toList();
            return Container(
              child: ListView(
                children: children,
              ),
            );
          },
        ));
  } */

  createUser() {
    // add => autogenera el ID
    userRef.add({"username": "Carla", "postsCount": 0, "isAdmin": false});
  }

  updateUser(String id) async {
    final doc = await userRef.document(id).get();
    if (doc.exists) {
      doc.reference.updateData(
          {"username": "Carlassss", "postsCount": 0, "isAdmin": false});
    }
  }

  deleteUser(String id) async {
    final doc = await userRef.document(id).get();
    if (doc.exists) {
      doc.reference.delete();
    }
  }

// ******************* USANDO StreamBuilder => tiempo real ******************* //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header(context, isAppTitle: true),
        body: StreamBuilder<QuerySnapshot>(
          stream: userRef.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              //print(snapshot.data.documents);
              return circularProgress();
            }

            final List<Text> children = snapshot.data.documents
                .map((doc) => Text(doc["username"]))
                .toList();
            return Container(
              child: ListView(
                children: children,
              ),
            );
          },
        ));
  }
}
