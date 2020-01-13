import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share/widgets/header.dart';

final userRef = Firestore.instance.collection("users");

class Timeline extends StatefulWidget {
  Timeline({Key key}) : super(key: key);

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  void initState() {
    super.initState();
    //getUsers();
  }

/*   getUsers() {
    userRef.getDocuments().then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((DocumentSnapshot doc) {
        print(doc.data);
        print(doc.documentID);
        print(doc.exists); // true | false
      });
    });
  } */

  /*  getUserById() {
    final String id = "c3fcew";
    userRef.document(id).get().then((DocumentSnapshot doc) {
      print(doc.data);
      print(doc.documentID);
      print(doc.exists);
    });
  } */

  getUserById_2() async {
    final String id = "c3fcew";
    final DocumentSnapshot doc = await userRef.document(id).get();
    print(doc.data);
    print(doc.documentID);
    print(doc.exists);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: Text("Tomeline"),
    );
  }
}
