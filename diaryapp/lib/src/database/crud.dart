import 'package:diaryapp/src/database/db.dart';
import 'package:sqflite/sqflite.dart';

class Crud {
  final String table;

  Crud(this.table);

  // Abrir conexión
  Future<Database> get database async {
    return await DB().open();
  }

  query() async {
    final db = await database;
    if (db == null || !db.isOpen) {
      print('NO ESTÁ ABIERTA');
    } else {
      return await db.query(table);
    }
  }

  update(Map<String, dynamic> values) async {
    final db = await database;
    return await db
        .update(table, values, where: 'id = ?', whereArgs: [values['id']]);
  }

  insert(Map<String, dynamic> values) async {
    final db = await database;
    if (db == null || !db.isOpen) {
      print('NO ESTÁ ABIERTA');
    } else {
      return await db.insert(table, values);
    }
  }

  delete(int id) async {
    final db = await database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
