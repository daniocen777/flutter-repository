import 'package:flutter/material.dart';

import 'package:cupertinoapp/src/blocs/master/master_bloc.dart';
import 'package:cupertinoapp/src/blocs/master/master_event.dart';
import 'package:cupertinoapp/src/blocs/master/master_state.dart';

import 'package:cupertinoapp/src/widgets/page-view_widget.dart';
import 'package:cupertinoapp/src/classes/bottom-menu-item_class.dart';
import 'package:cupertinoapp/src/pages/home-tabs_pages/histoy-tab_page.dart';
import 'package:cupertinoapp/src/pages/home-tabs_pages/home-tab_page.dart';
import 'package:cupertinoapp/src/pages/home-tabs_pages/more-tab_page.dart';
import 'package:cupertinoapp/src/pages/home-tabs_pages/profile-tab_page.dart';
import 'package:cupertinoapp/src/pages/chat_page.dart';
import 'package:cupertinoapp/src/widgets/appbar_widget.dart';
import 'package:cupertinoapp/src/widgets/bottom-menu_widget.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'image_page.dart';

class HomePage extends StatefulWidget {
  static final routename = 'home';

  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    final bloc = BlocProvider.of<MasterBloc>(context);
    return Scaffold(
        bottomNavigationBar: BlocBuilder<MasterBloc, MasterState>(
            builder: (BuildContext context, MasterState state) {
              return BottomMenu(
                currentPage: state.currentTab,
                onChange: (int newCurrentPage) {
                  bloc.add(MasterSetTab(tab: newCurrentPage));
                },
                items: _menu,
              );
            },
            condition: (prevState, newState) =>
                prevState.currentTab != newState.currentTab),
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
                      child: BlocBuilder<MasterBloc, MasterState>(
                          builder: (BuildContext context, state) {
                            return MyPageView(
                                currentPage: state.currentTab,
                                children: _menu
                                    .map<Widget>((item) => item.content)
                                    .toList());
                          },
                          condition: (prevState, newState) =>
                              prevState.currentTab != newState.currentTab),
                    )
                  ],
                ))));
  }
}
