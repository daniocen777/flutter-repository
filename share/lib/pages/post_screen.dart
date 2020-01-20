import 'package:flutter/material.dart';
import 'package:share/pages/home.dart';
import 'package:share/widgets/header.dart';
import 'package:share/widgets/post.dart';
import 'package:share/widgets/progress.dart';

class PostScreen extends StatelessWidget {
  final String userId;
  final String postId;
  const PostScreen({Key key, this.userId, this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: postRef
          .document(userId)
          .collection("userPosts")
          .document(postId)
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        Post post = Post.fromDocument(snapshot.data);
        return Center(
          child: Scaffold(
              appBar: header(context, title: post.description),
              body: ListView(
                children: <Widget>[
                  Container(child: post),
                ],
              )),
        );
      },
    );
  }
}
