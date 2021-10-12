import 'package:flutter/material.dart';
import 'package:web_design/helpers/responsive.dart';
import 'package:web_design/widgets/side_menu.dart';
import 'package:web_design/widgets/small_screen.dart';
import 'package:web_design/widgets/top_bar.dart';

import '../widgets/largue_screen.dart';

class SiteLayout extends StatelessWidget {
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  const SiteLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0), // here the desired height
          child: TopBar(scaffoldKey: scaffoldKey)),
      drawer: Drawer(child: SideMenu()),
      body: ResponsiveWidwet(
        largueScreen: LargueScreen(),
        smallScreen: SmallScreen(),
      ),
    );
  }
}
