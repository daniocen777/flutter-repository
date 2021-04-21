import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastosapp/src/blocs/product/product_bloc.dart';
import './src/blocs/master/master_bloc.dart';
import './src/pages/home_page.dart';

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
      child: GestureDetector(
        /* Para el teclado del ios, minimizarlo al hacer tap */
        onTap: () {
          final FocusScopeNode focusScopeNode = FocusScope.of(context);
          if (!focusScopeNode.hasPrimaryFocus) {
            focusScopeNode.unfocus();
          }
        },
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Mis Gastos',
            routes: {
              HomePage.routename: (BuildContext context) => HomePage(),
            },
            home: HomePage()),
      ),
    );
  }
}
