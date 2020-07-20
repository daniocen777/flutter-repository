import 'package:flutter/material.dart';

class HistoryTabPage extends StatefulWidget {
  HistoryTabPage({Key key}) : super(key: key);

  @override
  _HistoryTabPageState createState() => _HistoryTabPageState();
}

class _HistoryTabPageState extends State<HistoryTabPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraint) {
      return Container(color: Colors.blue, height: constraint.maxHeight / 3);
    });
  }
}
