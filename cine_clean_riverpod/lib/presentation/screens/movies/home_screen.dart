import 'package:flutter/material.dart';

import '../../views/views.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.pageIndex});

  static const name = 'home-screen';
  final int pageIndex;

  final viewsRoutes = const <Widget>[
    HomeView(),
    Center(child: Text('Categorías'),),
    FavoritesView(),
  ];

 

  @override
  Widget build(BuildContext context) {
    // IndexedStack => Widget para preservar el estado
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: viewsRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: pageIndex,
      ),
    );
  }
}
