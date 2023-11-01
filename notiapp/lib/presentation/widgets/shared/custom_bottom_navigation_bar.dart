import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constans/page_index_and_name.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key, required this.currentIndex});

  final int currentIndex;

  void onItemTap(BuildContext context, int index) {
    switch (index) {
      case PageIndexAndName.homeViewIndex:
        context.go('/home/${PageIndexAndName.homeViewIndex}');
        break;
      case PageIndexAndName.localViewIndex:
        context.go('/home/${PageIndexAndName.localViewIndex}');
        break;
      case PageIndexAndName.favoritesViewIndex:
        context.go('/home/${PageIndexAndName.favoritesViewIndex}');
        break;
      default:
        context.go('/home/${PageIndexAndName.homeViewIndex}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0.0,
      currentIndex: currentIndex,
      onTap: (value) => onItemTap(context, value),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Inicio'),
        BottomNavigationBarItem(
            icon: Icon(Icons.label_outline), label: 'Categorías'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline), label: 'Favoritos'),
      ],
    );
  }
}
