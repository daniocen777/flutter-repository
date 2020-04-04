import 'dart:async';

import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  bool _isSidebarOpened = false;
  final _animationDuration = Duration(milliseconds: 500);
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    //isSidebarOpenedStreamController = PublishSubject<bool>();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return AnimatedPositioned(
      duration: _animationDuration,
      top: 0,
      bottom: 0,
      left: _isSidebarOpened ? 0 : 0,
      right: _isSidebarOpened ? 0 : _screenWidth - 45,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.lightBlue[600],
            ),
          ),
          Align(
            alignment: Alignment(0, -0.9),
            child: Container(
              width: 35.0,
              height: 110.0,
              color: Colors.lightBlue[600],
              alignment: Alignment.centerLeft,
              child: AnimatedIcon(
                progress: _animationController.view,
                icon: AnimatedIcons.menu_close,
                color: Colors.white,
                size: 25.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
