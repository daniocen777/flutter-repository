import 'package:flutter/material.dart';
import 'package:animaciones/src/pages/first_page.dart';
import 'package:animaciones/src/sidebar/sidebar.dart';

class SideBarLayout extends StatelessWidget {
  const SideBarLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[FirstPage(), SideBar()],
      ),
    );
  }
}
