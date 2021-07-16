import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastosapp/src/blocs/product/product_bloc.dart';
import './src/blocs/master/master_bloc.dart';
import './src/pages/home_page.dart';
import 'src/pages/add_product_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => MasterBloc()),
        BlocProvider(create: (BuildContext context) => ProductBloc()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mis Gastos',
          routes: {
            HomePage.routename: (BuildContext context) => HomePage(),
            AddProductPage.routename: (BuildContext context) =>
                AddProductPage(),
          },
          home: HomePage()),
    );
  }
}
