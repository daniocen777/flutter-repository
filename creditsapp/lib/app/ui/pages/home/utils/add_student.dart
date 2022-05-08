import 'package:creditsapp/app/domain/inputs/student.dart';
import 'package:flutter/widgets.dart';

import 'package:creditsapp/app/ui/pages/home/home_page.dart' show homeProvider;

Future<void> addStudent(BuildContext context) async {
  final homeController = homeProvider.read;
  final result = await homeController.add();
  print('************ RESULT => $result');
  if (result > 0) {
    print('OK');
  } else {
    print('ERROR');
  }
}

Future<void> list(BuildContext context) async {
  final homeController = homeProvider.read;
  final result = await homeController.list();
  for (Student element in result) {
    print(element.name);
  }
}
