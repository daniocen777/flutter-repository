import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/chat/message_bubble.dart';

class MessagesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference _chats = FirebaseFirestore.instance.collection('chat');
    final _user = FirebaseAuth.instance.currentUser;

    return StreamBuilder(
      stream: _chats.orderBy('createdAt', descending: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
              child: Text('Ocurrió un error, tal vez no estás conectado'));
        }

        final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          physics: BouncingScrollPhysics(),
          itemCount: documents.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                padding: EdgeInsets.all(8.0),
                child: MessageBubble(
                  message: documents[index]['text'] ?? '',
                  isMe: documents[index]['userId'] == _user!.uid,
                  key: ValueKey(documents[index].id),
                  username: documents[index]['username'],
                ));
          },
        );
      },
    );
  }
}
