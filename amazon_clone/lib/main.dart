import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:amazon_clone/blocs/auth/auth_bloc.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (_) => AuthBloc())],
        child: MaterialApp(
          title: 'Amazon App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: GlobalVariables.backgroundColor,
            colorScheme: const ColorScheme.light(
              primary: GlobalVariables.secondaryColor,
            ),
            appBarTheme: const AppBarTheme(
                elevation: 0.0, iconTheme: IconThemeData(color: Colors.black)),
          ),
          initialRoute: AuthScreen.route,
          routes: getApplicationRoutes(),
        ));
  }
}
