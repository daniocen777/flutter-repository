part of 'employee_bloc.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object> get props => [];
}

class GetEmployeesEvent extends EmployeeEvent {}

class AddEmployeesEvent extends EmployeeEvent {}
