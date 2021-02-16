import 'package:flutter/material.dart';
import 'package:pages_samples/rappi_scroll_sync/models/data.dart';
import 'package:pages_samples/rappi_scroll_sync/models/rappi_item.dart';
import 'package:pages_samples/rappi_scroll_sync/models/rappi_tab_category.dart';

class RappiBloc with ChangeNotifier {
  List<RappiTabCategory> tabs = [];
  List<RappiItem> items = []; // categoría y productos
  TabController tabController;
  ScrollController scrollController = ScrollController();
  bool _listen = true;

  double categoryHight = 55.0; // Título de categoría
  double productHight = 100.0; // Tarjeta

  void init(TickerProvider ticker) {
    tabController =
        TabController(length: RAPPI_CATEGORIES.length, vsync: ticker);
    double offsetFrom = 0.0;
    double offsetTo = 0.0;
    for (int i = 0; i < RAPPI_CATEGORIES.length; i++) {
      final category = RAPPI_CATEGORIES[i];
      if (i > 0) {
        offsetFrom += RAPPI_CATEGORIES[i - 1].products.length * productHight;
      }
      if (i < RAPPI_CATEGORIES.length - 1) {
        offsetTo +=
            offsetFrom + RAPPI_CATEGORIES[i + 1].products.length * productHight;
      } else {
        offsetTo = double.infinity;
      }
      tabs.add(RappiTabCategory(
          category: category,
          selected: (i == 0),
          offsetFrom: categoryHight * i + offsetFrom,
          offsetTo: offsetTo));
      this.items.add(RappiItem(category: category));
      for (int j = 0; j < category.products.length; j++) {
        final product = category.products[j];
        this.items.add(RappiItem(product: product));
      }
    }
    scrollController.addListener(_onScrollListener);
  }

/* Scroll vertical */
  void _onScrollListener() {
    if (_listen) {
      for (int i = 0; i < tabs.length; i++) {
        final tab = tabs[i];
        if ((scrollController.offset >= tab.offsetFrom) &&
            (scrollController.offset <= tab.offsetTo) &&
            (!tab.selected)) {
          onCategorySelected(i, animatedRequired: false);
          tabController.animateTo(i);
          break;
        }
      }
    }
  }

  void onCategorySelected(int index, {bool animatedRequired = true}) async {
    final categorySelected = tabs[index];
    for (int i = 0; i < tabs.length; i++) {
      tabs[i] = tabs[i]
          .copyWith(categorySelected.category.name == tabs[i].category.name);
    }
    notifyListeners();
    if (animatedRequired) {
      _listen = false;
      await scrollController.animateTo(categorySelected.offsetFrom,
          duration: const Duration(
            milliseconds: 500,
          ),
          curve: Curves.linear);
      _listen = true;
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    tabController.dispose();
    scrollController.removeListener(_onScrollListener);
    super.dispose();
  }
}
