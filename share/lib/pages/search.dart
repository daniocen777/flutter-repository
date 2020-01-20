import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share/models/user.dart';
import 'package:share/pages/activity_feed.dart';
import 'package:share/widgets/progress.dart';

final _userRef = Firestore.instance.collection("users");

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchController = TextEditingController();
  Future<QuerySnapshot> _searchResultsFuture;

  _handleSearch(String query) {
    Future<QuerySnapshot> _users = _userRef
        .where("displayName", isGreaterThanOrEqualTo: query)
        .getDocuments();
    setState(() {
      _searchResultsFuture = _users;
    });
  }

  _clearSearch() {
    _searchController.clear();
  }

  AppBar _buildSearchField() {
    return AppBar(
      backgroundColor: Colors.white,
      title: TextFormField(
        controller: _searchController,
        decoration: InputDecoration(
            hintText: "Search for a user...",
            filled: true,
            prefixIcon: Icon(
              Icons.account_box,
              size: 28.0,
            ),
            suffixIcon:
                IconButton(icon: Icon(Icons.clear), onPressed: _clearSearch)),
        onFieldSubmitted: _handleSearch,
      ),
    );
  }

  Container _buildNoContent() {
    final Orientation _orientation = MediaQuery.of(context).orientation;
    return Container(
      child: Center(
        child: ListView(
          // Usado cuando aparece el teclado y el contenido quede intacto
          shrinkWrap: true,
          children: <Widget>[
            SvgPicture.asset(
              "assets/images/search.svg",
              height: _orientation == Orientation.portrait ? 200.0 : 100.0,
            ),
            Text("Find user",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    fontSize: 60.0))
          ],
        ),
      ),
    );
  }

  buildSearchResults() {
    return FutureBuilder(
      future: _searchResultsFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        List<UserResult> _searchResults = [];
        snapshot.data.documents.forEach((doc) {
          User user = User.fromDocument(doc);
          UserResult searchResults = UserResult(user);
          _searchResults.add(searchResults);
        });
        return ListView(
          children: _searchResults,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
      appBar: _buildSearchField(),
      body: _searchResultsFuture == null
          ? _buildNoContent()
          : buildSearchResults(),
    );
  }
}

class UserResult extends StatelessWidget {
  final User user;

  UserResult(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.7),
      child: Column(
        children: <Widget>[
          GestureDetector(
              onTap: () => showProfile(context, profileId: user.id),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: CachedNetworkImageProvider(user.photoUrl),
                ),
                title: Text(user.displayName,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle:
                    Text(user.username, style: TextStyle(color: Colors.white)),
              )),
          Divider(height: 2.0, color: Colors.white54)
        ],
      ),
    );
  }
}
