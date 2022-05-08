import 'package:creditsapp/app/domain/inputs/student.dart';
import 'package:creditsapp/app/domain/repositories/student_repository.dart';
import 'package:flutter_meedu/meedu.dart';

class HomeController extends SimpleNotifier {
  final _studentRepository = Get.i.find<StudentRepository>();
  final Student _student = Student(
      dni: '87654321', name: 'lola', hours: 1, minutes: 30, credits: 1);

  Future<int> add() async {
    return await _studentRepository.insert(_student);
  }

  Future<List<Student>> list() async {
    return await _studentRepository.list();
  }
}
