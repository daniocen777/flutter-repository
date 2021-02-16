import 'package:flutter/material.dart';

import 'package:pages_samples/rappi_scroll_sync/utils/colors.dart';
import 'package:pages_samples/rappi_scroll_sync/utils/rappi_bloc.dart';
import 'package:pages_samples/rappi_scroll_sync/widgets/rappi_category_item.dart';
import 'package:pages_samples/rappi_scroll_sync/widgets/rappi_product_item.dart';
import 'package:pages_samples/rappi_scroll_sync/widgets/rappi_tab.dart';

class RappiScrollSyncPage extends StatefulWidget {
  RappiScrollSyncPage({Key key}) : super(key: key);

  @override
  _RappiScrollSyncPageState createState() => _RappiScrollSyncPageState();
}

class _RappiScrollSyncPageState extends State<RappiScrollSyncPage>
    with SingleTickerProviderStateMixin {
  final _bloc = RappiBloc();

  

  @override
  void initState() {
    super.initState();
    _bloc.init(this);
  }

  @override
  void dispose() { 
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        body: SafeArea(
            child: AnimatedBuilder(
          animation: _bloc,
          builder: (BuildContext context, Widget child) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 80.0,
                alignment: Alignment.bottomLeft,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Home Page',
                          style: TextStyle(
                              color: BLUE_COLOR,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w700)),
                      CircleAvatar(
                        backgroundColor: GREEN_COLOR,
                        radius: 16.0,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/rappi/logo.png',
                            height: 30.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 60.0,
                child: TabBar(
                    physics: BouncingScrollPhysics(),
                    onTap: _bloc.onCategorySelected,
                    controller: _bloc.tabController,
                    isScrollable: true,
                    // El grosor de la línea que aparece debajo de la pestaña seleccionada.
                    indicatorWeight: 0.1,
                    tabs: _bloc.tabs
                        .map((element) => RappiTabWidget(tabCategory: element))
                        .toList()),
              ),
              /* Lista */
              Expanded(
                child: ListView.builder(
                  controller: _bloc.scrollController,
                  physics: BouncingScrollPhysics(),
                  itemCount: _bloc.items.length,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  itemBuilder: (BuildContext context, int index) {
                    final item = _bloc.items[index];
                    // Si el index es impar, mostrar las categorías
                    if (item.isCategory) {
                      return RappiCategoryItem(
                          categoryHight: _bloc.categoryHight,
                          category: item.category);
                    } else {
                      return RappiProductItem(
                          productHight: _bloc.productHight,
                          product: item.product);
                    }
                  },
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
