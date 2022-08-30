import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tip_calculator/blocs/bloc/tip_bloc.dart';
import 'package:tip_calculator/routes/app_routes.dart';
import 'package:tip_calculator/routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (_) => TipBloc())],
        child: MaterialApp(
            title: 'Material App',
            debugShowCheckedModeBanner: false,
            routes: appRoutes,
            initialRoute: Routes.tip));
  }
}
