import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/employee.dart';

part 'employee_event.dart';
part 'employee_state.dart';

List<Employee> employeesList = [
  Employee(id: 1, name: 'Lola'),
  Employee(id: 2, name: 'Pepe'),
  Employee(id: 3, name: 'Carlos'),
];

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeInitial()) {
    on<EmployeeEvent>((event, emit) {
      if (event is EmployeeInitial) {
        emit(EmployeeInitial());
      }

      if (event is GetEmployeesEvent) {
        emit(EmployeeListState(employees: employeesList));
      }

      if (event is AddEmployeesEvent) {
        emit(LoadingState());
        int idRandom = Random().nextInt(500) + 1;
        String nameRandom = getRandomString(10);
        Employee employeeToAdd = Employee(id: idRandom, name: nameRandom);
        employeesList.add(employeeToAdd);
        print(employeesList.length);
        emit(AddState(employees: employeesList));
      }
    });
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
