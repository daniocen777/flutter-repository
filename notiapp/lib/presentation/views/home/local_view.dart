import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/counter/counter_bloc.dart';

class LocalView extends StatelessWidget {
  const LocalView({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => counterBloc.add(const IncreaseEvent())),
      body: BlocBuilder<CounterBloc, int>(
        builder: (context, state) {
          if (state is CounterInitial) {
            return const Center(
              child: Text('Presionar'),
            );
          } else if (state is CounterFinalState) {
            return Center(
              child: Text('Contador => $state'),
            );
          }

          return Center(
            child: Text('Contador => $state'),
          );
        },
      ),
    );
  }
}
