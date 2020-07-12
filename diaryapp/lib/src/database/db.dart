import 'package:diaryapp/src/database/db_tables.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  String nameDB = 'DiaryApp';
  int version = 1;

  open() async {
    String path = join(await getDatabasesPath(), nameDB);
    return await openDatabase(path,
        version: version, onConfigure: onConfigure, onCreate: onCreate);
  }
}

onConfigure(Database db) async {
  // Para usar llaves foráneas
  await db.execute('PRAGMA foreign_keys = ON');
}

onCreate(Database db, int version) async {
  DBTable.TABLES.forEach((script) async => await db.execute(script));
}
