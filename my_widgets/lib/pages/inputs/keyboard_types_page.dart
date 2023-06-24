import 'package:flutter/material.dart';

class KeyboardTypesPage extends StatelessWidget {
  const KeyboardTypesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(25.0),
        children: [
          const TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              label: Text('Correo'),
            ),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 20.0),
          const TextField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              label: Text('Teléfono'),
            ),
          ),
          const SizedBox(height: 20.0),
          const TextField(
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: true),
            decoration: InputDecoration(
              label: Text('Precio'),
            ),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 20.0),
          TextField(
            keyboardType: TextInputType.name,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(
              label: Text('Nombre'),
            ),
            textInputAction: TextInputAction.send,
            onSubmitted: (value) => print('El valor es $value'),
          ),
        ],
      ),
    );
  }
}
