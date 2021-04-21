import 'package:flutter/material.dart';

class MyPageView extends StatefulWidget {
  final int currentPage;
  final List<Widget> children;

  MyPageView({Key? key, required this.currentPage, required this.children});

  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  List<int> _renderPages = [0];

  @override
  void didUpdateWidget(MyPageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_renderPages.contains(widget.currentPage)) {
      setState(() {
        _renderPages.add(widget.currentPage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
        index: widget.currentPage,
        children: List.generate(widget.children.length, (index) {
          return _renderPages.contains(index)
              ? widget.children[index]
              : Container();
        }));
  }
}
