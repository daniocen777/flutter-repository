import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastosapp/src/pages/add_product_page.dart';
import 'package:gastosapp/src/pages/home_tabs/record_tab.dart';
import 'package:gastosapp/src/widgets/appbar_widget.dart';

import '../blocs/master/master_bloc.dart';
import '../classes/bottom_menu_item.dart';
import 'home_tabs/payments_tab.dart';

import '../widgets/bottom_menu.dart';
import '../widgets/page-view_widget.dart';
import 'home_tabs/products_tab.dart';

class HomePage extends StatefulWidget {
  static final routename = 'home';

  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _menu = <BottomMenuItem>[
    BottomMenuItem(
        iconPath: "assets/icons/products.svg",
        label: "Productos",
        content: ProductsTab()),
    BottomMenuItem(
        iconPath: "assets/icons/money.svg",
        label: "A Pagar",
        content: PaymentsTab()),
    BottomMenuItem(
        iconPath: "assets/icons/payday.svg",
        label: "Acumulado",
        content: RecordTab()),
  ];

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MasterBloc>(context);

    void _addProduct() {
      Navigator.pushNamed(context, AddProductPage.routename);
    }

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: BlocBuilder<MasterBloc, MasterState>(
            builder: (BuildContext context, MasterState state) {
              return BottomMenu(
                currentPage: state.currentTab,
                onChange: (int newCurrentPage) {
                  bloc.add(MasterSetTab(tab: newCurrentPage));
                },
                items: _menu,
              );
            },
            buildWhen: (prevState, newState) =>
                prevState.currentTab != newState.currentTab),
        floatingActionButton: BlocBuilder<MasterBloc, MasterState>(
            builder: (BuildContext context, MasterState state) {
          if (state.currentTab == 0) {
            return FloatingActionButton(
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                backgroundColor: Colors.amber,
                onPressed: _addProduct);
          }

          return Container(
            width: 0.0,
            height: 0.0,
          );
        }),
        body: SafeArea(
            child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    BlocBuilder<MasterBloc, MasterState>(
                        builder: (BuildContext context, state) {
                          if (state.currentTab == 0) {
                            return MyAppBar(
                              title: 'Productos Disponibles',
                            );
                          } else if (state.currentTab == 1) {
                            return MyAppBar(
                              title: 'Costo Total',
                              price: 12.20,
                            );
                          }
                          return MyAppBar(
                            title: 'Acumulado',
                            price: 400.00,
                          );
                        },
                        buildWhen: (prevState, newState) =>
                            prevState.currentTab != newState.currentTab),
                    Expanded(
                      child: BlocBuilder<MasterBloc, MasterState>(
                          builder: (BuildContext context, state) {
                            return MyPageView(
                                currentPage: state.currentTab,
                                children: _menu
                                    .map<Widget>((item) => item.content)
                                    .toList());
                          },
                          buildWhen: (prevState, newState) =>
                              prevState.currentTab != newState.currentTab),
                    )
                  ],
                ))));
  }
}
