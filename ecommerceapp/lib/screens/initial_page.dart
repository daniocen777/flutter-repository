import '../consts/my_icons.dart';

import 'package:ecommerceapp/consts/colors.dart';

import 'feeds/feeds_page.dart';
import 'search/search_page.dart';
import 'package:flutter/material.dart';
import 'cart/cart_screen.dart';
import 'home/home_page.dart';
import 'user/user_info_page.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  List<Map<String, Widget>>? _pages;
  int _selectedPageIndex = 4;

  @override
  void initState() {
    _pages = [
      {
        'page': HomePage(),
      },
      {
        'page': FeedsPage(),
      },
      {
        'page': SearchPage(),
      },
      {
        'page': CartScreen(),
      },
      {
        'page': UserInfo(),
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages![_selectedPageIndex]['page'],
      bottomNavigationBar: BottomAppBar(
        // color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 0.01,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight * 1.25,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
              onTap: _selectPage,
              backgroundColor: Theme.of(context).primaryColor,
              unselectedItemColor: accentColor,
              selectedItemColor: primaryColor,
              currentIndex: _selectedPageIndex,
              items: [
                BottomNavigationBarItem(
                  icon: MyAppIcons.home,
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: MyAppIcons.rss,
                  label: 'Feeds',
                ),
                BottomNavigationBarItem(
                  activeIcon: null,
                  icon: Icon(null),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: MyAppIcons.cart,
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: MyAppIcons.user,
                  label: 'User',
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          hoverElevation: 10,
          splashColor: Colors.grey,
          tooltip: 'Search',
          elevation: 4,
          child: MyAppIcons.search,
          onPressed: () => setState(() {
            _selectedPageIndex = 2;
          }),
        ),
      ),
    );
  }
}
