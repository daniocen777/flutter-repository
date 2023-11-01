import 'package:flutter/material.dart';

import '../views/home/favorite_view.dart';
import '../views/home/home_view.dart';
import '../views/home/local_view.dart';
import '../widgets/shared/custom_bottom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.pageIndex});

  final int pageIndex;
  final viewsRoutes = const <Widget>[
    HomeView(),
    LocalView(),
    FavoriteView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: viewsRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: pageIndex),
    );
  }
}
