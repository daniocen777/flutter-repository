import 'package:creditsapp/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_meedu/meedu.dart';

import 'package:creditsapp/app/ui/routes/routes.dart';

class SplashController extends SimpleNotifier {
  final _authenticationRepository = Get.i.find<AuthenticationRepository>();
  String? _routeName;
  String? get routeName => _routeName;

  SplashController() {
    _init();
  }

  void _init() async {
    final ilLogued = await _authenticationRepository.isLogued;
    print('****** ilLogued => $ilLogued');
    if (ilLogued) {
      _routeName = Routes.home;
    } else {
      _routeName = Routes.login;
    }

    notify();
  }
}
