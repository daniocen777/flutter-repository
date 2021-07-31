import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:get_it/get_it.dart';

import 'package:flutter/services.dart';
import 'package:moviesapp/models/config.dart';
import 'package:moviesapp/services/http.dart';
import 'package:moviesapp/services/movies_service.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  SplashPage({Key? key, required this.onInitializationComplete})
      : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000)).then((_) =>
        this._setup(context).then((_) => widget.onInitializationComplete()));
  }

  Future<void> _setup(BuildContext context) async {
    final getIt = GetIt.instance;
    final configureFile =
        await rootBundle.loadString('assets/config/main.json');
    final configData = jsonDecode(configureFile);
    getIt.registerSingleton<AppConfig>(AppConfig(
        baseApiUrl: configData['BASE_API_URL'],
        baseImageApiUrl: configData['BASE_IMAGE_API_URL'],
        apiKey: configData['API_KEY']));

    getIt.registerSingleton<HttpService>(HttpService());
    getIt.registerSingleton<MoviesService>(MoviesService());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Movies',
            theme: ThemeData(primarySwatch: Colors.blue),
            home: Center(
                child: Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage('assets/images/logo.png')))))));
  }
}
