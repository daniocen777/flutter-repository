import 'package:flutter/material.dart';

import '../widgets/custom_drawer.dart';
import '../data/data.dart';
import '../widgets/posts_carousel.dart';
import '../widgets/following_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data:
            ThemeData(primaryColor: Colors.blue, backgroundColor: Colors.white),
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.white,
                brightness: Brightness.light,
                iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                title: Text('FRENDZY',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 10.0)),
                bottom: TabBar(
                    controller: _tabController,
                    labelColor: Theme.of(context).primaryColor,
                    labelStyle:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
                    unselectedLabelStyle: TextStyle(fontSize: 15.0),
                    tabs: [
                      Tab(text: 'Tendencias'),
                      Tab(text: 'Últimos posts')
                    ])),
            drawer: CustomDrawer(),
            body: ListView(physics: BouncingScrollPhysics(), children: [
              // Seguidores
              FollowingUsers(),
              // Posts
              PostsCarousel(
                  pageController: _pageController,
                  title: 'Posts',
                  posts: posts),
              SizedBox(height: 50.0)
            ])));
  }
}
