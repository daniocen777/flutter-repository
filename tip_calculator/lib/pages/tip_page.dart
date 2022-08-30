import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tip_calculator/blocs/bloc/tip_bloc.dart';
import 'package:tip_calculator/widgets/custom_input_field.dart';

class TipPage extends StatelessWidget {
  const TipPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TipBloc tipBloc = context.read<TipBloc>();
    return BlocBuilder<TipBloc, TipState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
                child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  Container(
                      width: 190.0,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.deepPurple[100],
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Total por persona',
                                style: TextStyle(color: Colors.deepPurple)),
                            Text('S/ ${state.amountPerPerson}',
                                style: const TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700))
                          ])),
                  const SizedBox(height: 20.0),
                  Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(66, 59, 54, 54),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Column(children: [
                        CustomInputField(
                            label: 'Monto de la cuenta',
                            inputType: TextInputType.number,
                            onChanged: (value) {
                              tipBloc.add(
                                  AmountPerPersonEvent(double.parse(value), 2));
                            })
                      ]))
                ],
              ),
            )),
          ),
        );
      },
    );
  }
}
