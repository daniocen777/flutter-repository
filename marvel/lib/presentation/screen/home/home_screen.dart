import 'package:flutter/material.dart';

import '../../view/views.dart';
import '../../widgets/shared/custom_bottom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.pageIndex});

  static const name = 'home-screen';
  final int pageIndex;

  final viewRoutes = const <Widget>[CharacterView(), ComicView(), SerieView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marvel'),
      ),
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: pageIndex),
    );
  }
}
