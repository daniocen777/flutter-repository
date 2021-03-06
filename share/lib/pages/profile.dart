import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/models/user.dart';
import 'package:share/pages/edit_profile.dart';

import 'package:share/widgets/header.dart';
import 'package:share/widgets/post.dart';
import 'package:share/widgets/post_tile.dart';
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
  // Para la vista (grid o lista de los posts)
  String _postOrientation = "grid"; // grid por defecto
  bool isFollowing = false; // Siguiendo a
  bool _isLoading = false;
  int postCount = 0;
  int followerCount = 0;
  int followingCount = 0;
  List<Post> posts = [];
  @override
  void initState() {
    super.initState();
    _getProfilePosts();
    _getFollowers();
    _getFollowing();
    _checkIsFollowing();
  }

  _checkIsFollowing() async {
    DocumentSnapshot doc = await followersRef
        .document(widget.profileId)
        .collection("userFollowers")
        .document(currentUserId)
        .get();

    setState(() {
      isFollowing = doc.exists;
    });
  }

  _getFollowers() async {
    QuerySnapshot snapshot = await followersRef
        .document(widget.profileId)
        .collection("userFollowers")
        .getDocuments();

    setState(() {
      followerCount = snapshot.documents.length;
    });
  }

  _getFollowing() async {
    QuerySnapshot snapshot = await followingRef
        .document(widget.profileId)
        .collection("userFollowing")
        .getDocuments();

    setState(() {
      followingCount = snapshot.documents.length;
    });
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
              style: TextStyle(
                  color: isFollowing ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold)),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: isFollowing ? Colors.white : Colors.blue,
              border: Border.all(
                color: isFollowing ? Colors.grey : Colors.blue,
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
    } else if (isFollowing) {
      return _buildButton(text: "Unfollow", function: _handleUnFollowUser);
    } else if (!isFollowing) {
      return _buildButton(text: "Follow", function: handleFollowUser);
    }
  }

  _handleUnFollowUser() {
    setState(() {
      isFollowing = false;
    });

    // Removiendo followes
    followersRef
        .document(widget.profileId)
        .collection("userFollowers")
        .document(currentUserId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    // Removiendo tus seguidores
    followingRef
        .document(currentUserId)
        .collection("userFollowing")
        .document(widget.profileId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    // eliminando Notificación
    activityFeedRef
        .document(widget.profileId)
        .collection("feedItems")
        .document(currentUserId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  handleFollowUser() {
    setState(() {
      isFollowing = true;
    });

    // Hacer que el usuario siga a otro usuario (actualizar sus seguidores)
    // Referencia a la colección
    followersRef
        .document(widget.profileId)
        .collection("userFollowers")
        .document(currentUserId)
        .setData({});
    // Actualizando tus seguidores
    followingRef
        .document(currentUserId)
        .collection("userFollowing")
        .document(widget.profileId)
        .setData({});
    // Notificación
    activityFeedRef
        .document(widget.profileId)
        .collection("feedItems")
        .document(currentUserId)
        .setData({
      "type": "follow",
      "ownerId": widget.profileId,
      "username": currentUser.username,
      "userId": currentUserId,
      "userProfileImg": currentUser.photoUrl,
      "timestamp": timestamp
    });
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
                            buildCountColumn("followers", followerCount),
                            buildCountColumn("following", followingCount),
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
    } else if (posts.isEmpty) {
      return Container(
        color: Theme.of(context).accentColor.withOpacity(0.6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              "assets/images/no_content.svg",
              height: 170.0,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                "No Posts",
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 38.0,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      );
    } else if (_postOrientation == "grid") {
      List<GridTile> gridTiles = [];
      posts.forEach((post) {
        gridTiles.add(GridTile(
          child: PostTile(post),
        ));
      });

      return GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        mainAxisSpacing: 1.5,
        crossAxisSpacing: 1.5,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: gridTiles,
      );
    } else if (_postOrientation == "list") {
      return Column(children: posts);
    }
  }

  _setPostOrientation(String postOrientation) {
    setState(() {
      this._postOrientation = postOrientation;
    });
  }

  buildTogglePostOrientation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.grid_on),
          color: _postOrientation == "grid"
              ? Theme.of(context).primaryColor
              : Colors.grey,
          onPressed: () => _setPostOrientation("grid"),
        ),
        IconButton(
            icon: Icon(Icons.list),
            color: _postOrientation == "list"
                ? Theme.of(context).primaryColor
                : Colors.grey,
            onPressed: () => _setPostOrientation("list"))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, title: "Profile"),
      body: ListView(
        children: <Widget>[
          _buildProfileHeader(),
          Divider(),
          buildTogglePostOrientation(),
          Divider(height: 0.0),
          _buildProfilePosts()
        ],
      ),
    );
  }
}
