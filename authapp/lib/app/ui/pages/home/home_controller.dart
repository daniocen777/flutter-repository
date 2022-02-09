import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';

class HomeController extends SimpleNotifier {
  // Guarar página activa
  late TabController tabController;

  HomeController() {
    tabController = TabController(length: 2, vsync: NavigatorState());
  }

  // Liberar tabController
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
