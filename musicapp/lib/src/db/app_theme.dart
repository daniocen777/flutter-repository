import 'package:flutter/material.dart';
import 'package:musicapp/src/db/db.dart';
import 'package:sembast/sembast.dart';

class MyAppTheme extends ChangeNotifier {
  MyAppTheme._internal();
  static MyAppTheme _instance = MyAppTheme._internal();
  static MyAppTheme get instance => _instance;

  final StoreRef _storeRef = StoreRef.main();
  final Database _db = DB.instance.database;

  bool _darkEnabled;
  bool get darkEnabled => _darkEnabled;
  final Color darkColor = Color(0xff102027);

  /*  Recuperar el valor de _darkEnabled */
  Future<void> init() async {
    this._darkEnabled =
        (await this._storeRef.record('darkEnabled').get(_db)) as bool ?? false;
  }

  Future<void> setTheme(bool isDarkEnabled) async {
    await this._storeRef.record('darkEnabled').put(_db, isDarkEnabled);
    this._darkEnabled = isDarkEnabled;
    notifyListeners();
  }

  ThemeData get theme {
    if (_darkEnabled) {
      return ThemeData(
          scaffoldBackgroundColor: this.darkColor,
          fontFamily: 'sans',
          brightness: Brightness.dark);
    }
    return ThemeData(fontFamily: 'sans');
  }
}
