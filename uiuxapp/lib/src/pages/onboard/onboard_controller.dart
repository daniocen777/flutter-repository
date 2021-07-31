import 'package:flutter/cupertino.dart';
import 'package:uiuxapp/src/data/models/onboard_item.dart';

class OnboardController extends ChangeNotifier {
  final PageController? pageController = PageController();
  double _currentPage = 0;
  double get currentPage => _currentPage;

  final List<OnboardItem> items = [
    OnboardItem(
        image: 'assets/pages/onboard/slider_1.svg',
        title: 'El pasaje estándar Lorem Ipsum, usado desde el año 1500',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'),
    OnboardItem(
        image: 'assets/pages/onboard/slider_2.svg',
        title: 'Sección 1.10.32 de "de Finibus Bonorum et Malorum"',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'),
    OnboardItem(
        image: 'assets/pages/onboard/slider_3.svg',
        title: 'Traducción hecha por H. Rackham en 1914',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.')
  ];

  /* Llamar esta función cuando la pantalla sea renderizada */
  void afterFirstLayout() {
    /* Escuchar los cambios del pageView */
    this.pageController!.addListener(() {
      final double? page = pageController!.page;
      _currentPage = page!;
      notifyListeners();
      /* if (page! % 1 == 0 && _currentPage != page) {
        _currentPage = page.toInt();
        notifyListeners();
        print('Current Page');
      } */
    });
  }

  @override
  void dispose() {
    this.pageController?.dispose();
    super.dispose();
  }
}
