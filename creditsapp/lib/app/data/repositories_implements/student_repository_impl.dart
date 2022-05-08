import 'package:sqflite/sqflite.dart';
import 'package:creditsapp/app/domain/db/conection.dart';
import 'package:creditsapp/app/domain/inputs/student.dart';
import 'package:creditsapp/app/domain/repositories/student_repository.dart';

class StudentRepositoryImpl extends StudentRepository {
  final DB _db;
  StudentRepositoryImpl(this._db);

  @override
  Future<int> insert(Student student) async {
    Database database = await _db.openDB();
    return database.insert('students', student.toJson());
  }

  @override
  Future<List<Student>> list() async {
    Database database = await _db.openDB();
    final List<Map<String, dynamic>> students =
        await database.query('students');
    return List.generate(
        students.length,
        (index) => Student(
            dni: students[index]['dni'],
            name: students[index]['name'],
            hours: students[index]['hours'],
            minutes: students[index]['minutes'],
            credits: students[index]['credits']));
  }
}
