import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share/models/user.dart';
import 'package:share/pages/home.dart';
import 'package:share/widgets/progress.dart';

class EditProfile extends StatefulWidget {
  final String currentUserId;
  EditProfile({Key key, this.currentUserId}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _displayNameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  bool _isLoading = false;
  User _user;
  bool _displayNameValid = true;
  bool _bioValid = true;
  @override
  void initState() {
    super.initState();
    _getUser();
  }

  _getUser() async {
    setState(() {
      _isLoading = true;
    });
    DocumentSnapshot doc = await userRef.document(widget.currentUserId).get();
    _user = User.fromDocument(doc);
    _displayNameController.text = _user.displayName;
    _bioController.text = _user.bio;
    setState(() {
      _isLoading = false;
    });
  }

  Column _buildDisplaynameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "DisplayName",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: _displayNameController,
          decoration: InputDecoration(
              hintText: "Update Display Name",
              errorText: _displayNameValid ? null : "Display Name too short"),
        )
      ],
    );
  }

  Column _buildBioField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "Bio",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: _bioController,
          decoration: InputDecoration(
              hintText: "Update bio",
              errorText: _bioValid ? null : "Bio too long"),
        )
      ],
    );
  }

  _updateProfileData() {
    setState(() {
      ((_displayNameController.text.trim().length < 3) ||
              (_displayNameController.text.isEmpty))
          ? _displayNameValid = false
          : _displayNameValid = true;

      _bioController.text.trim().length > 100
          ? _bioValid = false
          : _bioValid = true;
    });

    if (_displayNameValid && _bioValid) {
      userRef.document(widget.currentUserId).updateData({
        "displayName": _displayNameController.text,
        "bio": _bioController.text,
      });
      SnackBar snackbar = SnackBar(content: Text("Profile updated"));
      _scaffoldKey.currentState.showSnackBar(snackbar);
    }
  }

  _logout() async {
    await googleSignIn.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Edit Profile",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.done, size: 30.0, color: Colors.green),
              onPressed: () => Navigator.pop(context))
        ],
      ),
      body: _isLoading
          ? circularProgress()
          : ListView(
              children: <Widget>[
                Container(
                    child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage:
                            CachedNetworkImageProvider(_user.photoUrl),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          _buildDisplaynameField(),
                          _buildBioField()
                        ],
                      ),
                    ),
                    RaisedButton(
                      onPressed: _updateProfileData,
                      child: Text(
                        "Update profile",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: FlatButton.icon(
                        onPressed: _logout,
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                        label: Text(
                          "Logout",
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                      ),
                    )
                  ],
                ))
              ],
            ),
    );
  }
}
