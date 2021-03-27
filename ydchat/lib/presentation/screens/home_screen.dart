import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:ydchat/presentation/pages/calls_page.dart';
import 'package:ydchat/presentation/pages/camera_page.dart';
import 'package:ydchat/presentation/pages/chat_page.dart';
import 'package:ydchat/presentation/pages/status_page.dart';
import 'package:ydchat/presentation/widgets/custom_tab_bar.dart';
import 'package:ydchat/presentation/widgets/theme/theme.dart';

class HomeScreen extends StatefulWidget {
  static final String route = 'home';
  final String? uid;

  const HomeScreen({Key? key, this.uid}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearch = false;
  int _currentPageIndex = 1;
  PageController _pageViewController = PageController(initialPage: 1);
  List<Widget> _pages = [CameraPage(), ChatPage(), StatusPage(), CallsPage()];

  Widget _buildSearch() {
    return SafeArea(
      bottom: false,
      child: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
          )
        ]),
        child: Center(
          child: TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20.0),
                hintText: 'Buscar...',
                suffix: InkWell(
                  onTap: () {
                    // TODO: Regresar de la búsqueda
                    setState(() {
                      _isSearch = false;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: FaIcon(FontAwesomeIcons.angleLeft),
                  ),
                )),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentPageIndex != 0
          ? AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: !_isSearch ? primaryColor : Colors.transparent,
              title: !_isSearch
                  ? Text('Chat Privado')
                  : Container(
                      height: 0.0,
                      width: 0.0,
                    ),
              flexibleSpace: !_isSearch
                  ? Container(height: 0.0, width: 0.0)
                  : _buildSearch(),
              actions: [
                Center(
                  child: InkWell(
                    child: FaIcon(FontAwesomeIcons.search),
                    onTap: () {
                      setState(() {
                        _isSearch = true;
                      });
                    },
                  ),
                ),
                Center(child: SizedBox(width: 30.0)),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: FaIcon(FontAwesomeIcons.ellipsisV),
                )),
              ],
            )
          : null,
      body: Column(
        children: [
          !_isSearch
              ? ((_currentPageIndex != 0)
                  ? CustomTabBar(index: _currentPageIndex)
                  : Container())
              : Container(),
          Expanded(
              child: PageView.builder(
            itemCount: _pages.length,
            physics: BouncingScrollPhysics(),
            controller: _pageViewController,
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return _pages[index];
            },
          ))
        ],
      ),
    );
  }
}
