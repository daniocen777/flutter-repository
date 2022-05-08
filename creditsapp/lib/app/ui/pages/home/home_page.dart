import 'package:creditsapp/app/ui/pages/home/controller/home_controller.dart';
import 'package:creditsapp/app/ui/pages/home/utils/add_student.dart';
import 'package:flutter/material.dart';

import 'package:creditsapp/app/domain/inputs/student.dart';
import 'package:creditsapp/app/ui/pages/home/widgets/label_button.dart';
import 'package:flutter_meedu/meedu.dart';

final homeProvider = SimpleProvider((_) => HomeController());

final List<Student> students = [
  Student(name: "Name 1", dni: "45542099", hours: 2, minutes: 10, credits: 1),
  Student(name: "Name 2", dni: "45542011", hours: 1, minutes: 40, credits: 2),
];

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => addStudent(context),
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              LabelButton(
                student: students[0],
                onPressed: () => list(context),
              ),
              LabelButton(student: students[1])
            ],
          ),
        ));
  }
}
