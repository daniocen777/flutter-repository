import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/app_state.dart';
import 'package:flutter_ecommerce/pages/login_page.dart';
import 'package:flutter_ecommerce/pages/product_page.dart';
import 'package:flutter_ecommerce/pages/register_page.dart';
import 'package:flutter_ecommerce/redux/actions.dart';
import 'package:flutter_ecommerce/redux/reducers.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() {
  final store = Store<AppState>(appReducer,
      initialState: AppState.initial(), middleware: [thunkMiddleware]);
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({this.store});
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'E-Commerce',
          routes: {
            "/login": (BuildContext context) => LoginPage(),
            "/register": (BuildContext context) => RegisterPage(),
            "/": (BuildContext context) => ProductPage(onInit: () {
                  // Despacha una acción (getUserAction) para obtener datos del usuario
                  StoreProvider.of<AppState>(context).dispatch(getUserAction);
                  // Despacha una acción (getUserAction) para obtener datos de productos
                  StoreProvider.of<AppState>(context)
                      .dispatch(getProductsAction);
                })
          },
          theme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.cyan[400],
              accentColor: Colors.deepOrange[200],
              textTheme: TextTheme(
                  headline:
                      TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                  title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                  body1: TextStyle(fontSize: 18.0))),
        ));
  }
}
