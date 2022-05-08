import 'package:creditsapp/app/domain/inputs/student.dart';

abstract class StudentRepository {
  Future<int> insert(Student student);

  Future<List<Student>> list();
}
