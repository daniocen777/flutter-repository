import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/profile_clipper.dart';
import '../widgets/posts_carousel.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late PageController _postsController;
  late PageController _favoritesController;

  @override
  void initState() {
    super.initState();
    this._postsController =
        PageController(initialPage: 0, viewportFraction: 0.8);
    this._favoritesController =
        PageController(initialPage: 0, viewportFraction: 0.8);
  }

  @override
  Future<void> dispose() async {
    this._postsController.dispose();
    this._favoritesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data:
            ThemeData(primaryColor: Colors.blue, backgroundColor: Colors.white),
        child: Scaffold(
            key: _scaffoldKey,
            drawer: CustomDrawer(),
            body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(children: [
                  Stack(alignment: Alignment.center, children: [
                    ClipPath(
                        clipper: ProfileClipper(),
                        child: Image(
                            width: double.infinity,
                            height: 250.0,
                            image: AssetImage(widget.user.backgroundImageUrl!),
                            fit: BoxFit.cover)),
                    Positioned(
                        top: 50.0,
                        left: 20.0,
                        child: IconButton(
                            icon: Icon(CupertinoIcons.line_horizontal_3,
                                size: 30.0, color: Colors.white),
                            onPressed: () =>
                                _scaffoldKey.currentState!.openDrawer())),
                    Positioned(
                        bottom: 10.0,
                        child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black45,
                                      offset: Offset(0.0, 2.0),
                                      blurRadius: 6.0)
                                ]),
                            child: ClipOval(
                                child: Image(
                                    width: 100.0,
                                    height: 100.0,
                                    image: AssetImage(
                                        widget.user.profileImageUrl!),
                                    fit: BoxFit.cover))))
                  ]),
                  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(widget.user.name!,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5))),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(children: [
                          Text('Seguidores',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(height: 2.0),
                          Text(widget.user.following.toString(),
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.w500))
                        ]),
                        Column(children: [
                          Text('Seguidos',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(height: 2.0),
                          Text(widget.user.followers.toString(),
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.w500))
                        ])
                      ]),
                  PostsCarousel(
                      pageController: _postsController,
                      title: 'Mis publicaciones',
                      posts: widget.user.posts!),
                  PostsCarousel(
                      pageController: _favoritesController,
                      title: 'Favoritos',
                      posts: widget.user.favorites!),
                  SizedBox(height: 50.0)
                ]))));
  }
}
