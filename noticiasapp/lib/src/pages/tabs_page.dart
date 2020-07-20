import 'package:flutter/material.dart';
import 'package:noticiasapp/src/pages/tab-1_page.dart';
import 'package:noticiasapp/src/pages/tab-2_page.dart';

import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavigatorModel(),
      child: Scaffold(
        /* PageView => scrool hacia la derecha */
        body: _Pages(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _navigatorModel = Provider.of<_NavigatorModel>(context);
    return BottomNavigationBar(
        currentIndex: _navigatorModel.currentPage,
        onTap: (index) => _navigatorModel.currentPage = index,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), title: Text('For you')),
          BottomNavigationBarItem(
              icon: Icon(Icons.public), title: Text('World'))
        ]);
  }
}

class _Pages extends StatelessWidget {
  const _Pages({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _navigatorModel = Provider.of<_NavigatorModel>(context);
    return PageView(
      controller: _navigatorModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[Tab1Page(), Tab2Page()],
    );
  }
}

/* Patrón Provider */
class _NavigatorModel with ChangeNotifier {
  int _currentPage = 0;
  PageController _pageController = new PageController();

  int get currentPage => this._currentPage;

  set currentPage(int value) {
    this._currentPage = value;
    _pageController.animateToPage(value,
        duration: Duration(milliseconds: 250), curve: Curves.easeIn);
    // Notificar
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
