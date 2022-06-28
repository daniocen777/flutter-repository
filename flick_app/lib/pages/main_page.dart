import 'package:flick_app/widgets/background_widget.dart';
import 'package:flick_app/widgets/foreground_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerWidget {
  late double _deviceWidth;
  late double _deviceHeight;
  late TextEditingController _searchTextFieldController;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    Size _size = MediaQuery.of(context).size;
    _deviceWidth = _size.width;
    _deviceHeight = _size.height;
    _searchTextFieldController = TextEditingController();

    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
        backgroundColor: Colors.black54,
        body: Container(
          width: _deviceWidth,
          height: _deviceHeight,
          child: Stack(
            alignment: Alignment.center,
            children: [
              BackgroundWidget(width: _deviceWidth, height: _deviceHeight),
              ForegroundWidget(
                  height: _deviceHeight,
                  width: _deviceWidth,
                  textEditingController: _searchTextFieldController)
            ],
          ),
        ));
  }
}
