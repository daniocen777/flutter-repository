import 'dart:convert';

import 'package:flick_app/models/app_config.dart';
import 'package:flick_app/services/http_service.dart';
import 'package:flick_app/services/movies_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;
  const SplashPage({Key? key, required this.onInitializationComplete})
      : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000)).then((value) =>
        _setup(context).then((_) => widget.onInitializationComplete()));
    /* _setup(context).then((_) => widget.onInitializationComplete()); */
  }

  Future<void> _setup(BuildContext context) async {
    final getIt = GetIt.instance;
    final configFile = await rootBundle.loadString('assets/config/main.json');
    final configData = jsonDecode(configFile);
    getIt.registerSingleton<AppConfig>(AppConfig(
        baseApiUrl: configData['BASE_API_URL'],
        baseImageApiUrl: configData['BASE_IMAGE_API_URL'],
        apiKey: configData['API_KEY']));

    getIt.registerSingleton<HttpService>(HttpService());
    getIt.registerSingleton<MoviesService>(MoviesService());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Movies App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Center(
          child: Container(
              width: 200.0,
              height: 200.0,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/images/logo.png')))),
        ));
  }
}
