part of 'employee_bloc.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object> get props => [];
}

class EmployeeInitial extends EmployeeState {}

class LoadingState extends EmployeeState {}

class EmployeeListState extends EmployeeState {
  final List<Employee> employees;

  const EmployeeListState({required this.employees});

  @override
  List<Object> get props => [employees];
}

class AddState extends EmployeeState {
  final List<Employee> employees;

  const AddState({required this.employees});

  @override
  List<Object> get props => [employees];
}
