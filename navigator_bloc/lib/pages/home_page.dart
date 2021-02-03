import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:navigator_bloc/blocs/master/master_bloc.dart';
import 'package:navigator_bloc/classes/bottom_menu_item.dart';
import 'package:navigator_bloc/pages/home-tabs_pages/config-tab_page.dart';
import 'package:navigator_bloc/pages/home-tabs_pages/favorites-tab_page.dart';
import 'package:navigator_bloc/pages/home-tabs_pages/history-tab_page.dart';
import 'package:navigator_bloc/pages/home-tabs_pages/home-tab_page.dart';
import 'package:navigator_bloc/widgets/appbar_widget.dart';
import 'package:navigator_bloc/widgets/bottom_menu.dart';
import 'package:navigator_bloc/widgets/page-view_widget.dart';

class HomePage extends StatefulWidget {
  static final routename = 'home';

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _menu = <BottomMenuItem>[
    BottomMenuItem(
        iconPath: "assets/icons/home-run.svg",
        label: "Home",
        content: HomeTabPage()),
    BottomMenuItem(
        iconPath: "assets/icons/book.svg",
        label: "Historial",
        content: HistoryTabPage()),
    BottomMenuItem(
        iconPath: "assets/icons/heart.svg",
        label: "Favoritos",
        content: FavoritosTabPage()),
    BottomMenuItem(
        iconPath: "assets/icons/open-menu.svg",
        label: "More",
        content: ConfigTabPage()),
  ];

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
            buildWhen: (prevState, newState) =>
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
                          buildWhen: (prevState, newState) =>
                              prevState.currentTab != newState.currentTab),
                    )
                  ],
                ))));
  }
}
