import 'package:flutter/material.dart';

import 'package:cupertinoapp/src/widgets/page-view_widget.dart';
import 'package:cupertinoapp/src/classes/bottom-menu-item_class.dart';
import 'package:cupertinoapp/src/pages/home-tabs_pages/histoy-tab_page.dart';
import 'package:cupertinoapp/src/pages/home-tabs_pages/home-tab_page.dart';
import 'package:cupertinoapp/src/pages/home-tabs_pages/more-tab_page.dart';
import 'package:cupertinoapp/src/pages/home-tabs_pages/profile-tab_page.dart';
import 'package:cupertinoapp/src/pages/chat_page.dart';
import 'package:cupertinoapp/src/widgets/appbar_widget.dart';
import 'package:cupertinoapp/src/widgets/bottom-menu_widget.dart';
import 'package:flutter/cupertino.dart';
import 'image_page.dart';

class HomePage extends StatefulWidget {
  static final routename = 'home';

  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;

  final _menu = <BottomMenuIten>[
    BottomMenuIten(
        iconPath: "assets/icons/home-run.svg",
        label: "Home",
        content: HomeTabPage()),
    BottomMenuIten(
        iconPath: "assets/icons/book.svg",
        label: "Historial",
        content: HistoryTabPage()),
    BottomMenuIten(
        iconPath: "assets/icons/profile.svg",
        label: "Perfil",
        content: ProfileTabPage()),
    BottomMenuIten(
        iconPath: "assets/icons/open-menu.svg",
        label: "More",
        content: MoreTabPage()),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomMenu(
          currentPage: _currentPage,
          onChange: (int newCurrentPage) {
            setState(() {
              _currentPage = newCurrentPage;
            });
          },
          items: _menu,
        ),
        body: SafeArea(
            child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    /* Appbar */
                    MyAppBar( 
                      leftIcon: 'assets/icons/camera.svg',
                      rightIcon: 'assets/icons/comment.svg',
                      onRightClick: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ChatPage(username: 'Danicode')));
                      },
                      onLeftClick: () {
                        Navigator.pushNamed(context, ImagePage.routename,
                            arguments: ImagePageArgs(
                                username: 'Dani', isActive: true));
                      },
                    ),
                    Expanded(
                        child: MyPageView(
                            currentPage: _currentPage,
                            children: _menu
                                .map<Widget>((item) => item.content)
                                .toList()))
                  ],
                ))));
  }
}
