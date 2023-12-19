import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/employee/employee_bloc.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<EmployeeBloc>(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('Pressss');
            counterBloc.add(
              AddEmployeesEvent(),
            );
          },
          backgroundColor: Colors.orangeAccent,
        ),
        body: BlocBuilder<EmployeeBloc, EmployeeState>(
          builder: (context, state) {
            if (state is EmployeeInitial) {
              return const Center(
                child: Text('Initial'),
              );
            }
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is EmployeeListState) {
              return Center(
                child: Text('List => ${state.employees.length.toString()}'),
              );
            }

            if (state is AddState) {
              return Center(
                child: Column(
                  children: [
                    const Text('Registro agregado'),
                    Text('OK => ${state.employees.length.toString()}')
                  ],
                ),
              );
            }

            return const Center(
              child: Text('Error'),
            );
          },
        ));
  }
}
