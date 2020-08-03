import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class DB {
  DB._internal();
  static DB _instance = DB._internal();
  static DB get instance => _instance;
  Database _database;
  Database get database => _database;

  /* Iniciando la DB */
  Future<void> init() async {
    final String dbName = 'flutter_sembast.db';
    /* Ruta donde se guadará la DB */
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final dbPath = join(dir, dbName);
    /* Creando la bd */
    this._database = await databaseFactoryIo.openDatabase(dbPath);
  }

  Future<void> close() async {
    await this._database.close();
  }
}
