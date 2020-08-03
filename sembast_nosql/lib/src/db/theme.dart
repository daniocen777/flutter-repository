import 'package:flutter/cupertino.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_nosql/src/db/db.dart';

class MyAppTheme extends ChangeNotifier {
  MyAppTheme._interna();
  static MyAppTheme _instance = MyAppTheme._interna();
  static MyAppTheme get instance => _instance;

  /* Usando el store principal => Para datos státicos, no modificados */
  final StoreRef _storeRef = StoreRef.main();
  final Database _db = DB.instance.database;

  bool _darkEnabled = false;
  bool get darkEnabled => _darkEnabled;

  /* Recuperando valor inicial guardado en la BD */
  Future<void> init() async {
    this._darkEnabled =
        (await this._storeRef.record('DARK_ENABLED').get(this._db)) ?? false;
  }

  change(bool darkEnabled) async {
    this._darkEnabled = darkEnabled;
    /* Guardando el tema */
    final dataSaved = await this
        ._storeRef
        .record('DARK_ENABLED')
        .put(this._db, this._darkEnabled);

    notifyListeners();
  }
}
