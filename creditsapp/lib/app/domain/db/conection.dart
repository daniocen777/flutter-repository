import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/* https://www.youtube.com/watch?v=LLYoryuCOlM */

class DB {
  DB();

  Future<Database> openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'students.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE students(id INTEGER PRIMARY KEY, dni TEXT, name TEXT, hours INTEGER, minutes INTEGER, credits INTEGER)');
    }, version: 1);
  }
}
