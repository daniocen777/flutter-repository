import 'package:flutter/material.dart';

import '../data/data.dart';
import '../widgtes/widgets.dart';
import '../pages/pages.dart';

class NavPage extends StatefulWidget {
  NavPage({Key? key}) : super(key: key);

  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  final List<Widget> _pages = [
    HomePage(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold()
  ];

  final List<IconData> _icons = const [
    Icons.home,
    Icons.ondemand_video,
    Icons.account_circle,
    Icons.groups_rounded,
    Icons.notification_add,
    Icons.menu_open
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
        length: _icons.length,
        child: Scaffold(
            appBar: Responsive.isDesktop(context)
                ? PreferredSize(
                    preferredSize: Size(screenSize.width, 100.0),
                    child: CustomAppBar(
                        currentUser: currentUser,
                        icons: _icons,
                        selectedIndex: _selectedIndex,
                        onTap: (index) {
                          setState(() {
                            _selectedIndex = index;
                          });
                        }),
                  )
                : null,
            body: IndexedStack(index: _selectedIndex, children: _pages),
            bottomNavigationBar: !Responsive.isDesktop(context)
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: CustomTabBar(
                        icons: _icons,
                        selectedIndex: _selectedIndex,
                        onTap: (index) {
                          setState(() {
                            _selectedIndex = index;
                          });
                        }))
                : const SizedBox.shrink()));
  }
}
