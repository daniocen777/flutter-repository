import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share/models/user.dart';
import 'package:share/pages/edit_profile.dart';

import 'package:share/widgets/header.dart';
import 'package:share/widgets/post.dart';
import 'package:share/widgets/progress.dart';

import 'home.dart';

class Profile extends StatefulWidget {
  final String profileId;
  Profile({Key key, this.profileId}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String currentUserId = currentUser?.id;
  bool _isLoading = false;
  int postCount = 0;
  List<Post> posts = [];
  @override
  void initState() {
    super.initState();
    _getProfilePosts();
  }

  _getProfilePosts() async {
    setState(() {
      _isLoading = true;
    });
    QuerySnapshot snapshot = await postRef
        .document(widget.profileId)
        .collection("userPosts")
        .orderBy("timestamp", descending: true)
        .getDocuments();

    setState(() {
      _isLoading = false;
      postCount = snapshot.documents.length;
      posts = snapshot.documents.map((doc) => Post.fromDocument(doc)).toList();
    });
  }

  Column buildCountColumn(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count.toString(),
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.only(top: 4.0),
          child: Text(label,
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey)),
        )
      ],
    );
  }

  _editProfile() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditProfile(currentUserId: currentUserId)));
  }

  Container _buildButton({String text, Function function}) {
    return Container(
      padding: EdgeInsets.only(top: 2.0),
      child: FlatButton(
        onPressed: function,
        child: Container(
          width: 200.0,
          height: 27.0,
          child: Text(text,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.blue,
              border: Border.all(
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
    );
  }

  _buildProfileButton() {
    /* viendo su propio perfil, debería mostrar el botón Editar perfil */
    bool isProfileOwner = currentUserId == widget.profileId;
    if (isProfileOwner) {
      return _buildButton(text: "Edit Profile", function: _editProfile);
    }
    return Text("Profile buttom");
  }

  FutureBuilder _buildProfileHeader() {
    return FutureBuilder(
      future: userRef.document(widget.profileId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        User user = User.fromDocument(snapshot.data);
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 40.0,
                    backgroundColor: Colors.grey,
                    backgroundImage: CachedNetworkImageProvider(user.photoUrl),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            buildCountColumn("posts", postCount),
                            buildCountColumn("followers", 0),
                            buildCountColumn("following", 0),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[_buildProfileButton()],
                        )
                      ],
                    ),
                  )
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 12.0),
                child: Text(user.username,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 4.0),
                child: Text(user.displayName,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 2.0),
                child: Text(user.bio),
              )
            ],
          ),
        );
      },
    );
  }

  _buildProfilePosts() {
    if (_isLoading) {
      return circularProgress();
    }

    return Column(children: posts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, title: "Profile"),
      body: ListView(
        children: <Widget>[
          _buildProfileHeader(),
          Divider(height: 0.0),
          _buildProfilePosts()
        ],
      ),
    );
  }
}
