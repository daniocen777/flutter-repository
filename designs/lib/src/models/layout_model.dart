import 'package:flutter/material.dart';

import 'package:designs/src/pages/slideshow_page.dart';

class LayoutModel with ChangeNotifier {
  Widget _currentPage = SlideshowPage();

  Widget get currentPage => this._currentPage;

  set currentPage(Widget page) {
    this._currentPage = page;
    notifyListeners();
  }
}
