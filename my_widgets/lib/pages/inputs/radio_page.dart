import 'package:flutter/material.dart';

class RadioPage extends StatefulWidget {
  const RadioPage({super.key});

  @override
  State<RadioPage> createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  String? _better;
  String? _gender;

  void _onGenreChanged(String? value) {
    setState(() {
      _gender = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(15.0),
          children: [
            const Text('¿Cuál es mejor?'),
            Row(
              children: [
                Radio<String>(
                  value: 'flutter',
                  groupValue: _better,
                  onChanged: _onGenreChanged,
                ),
                const Text('Flutter')
              ],
            ),
            Row(
              children: [
                Radio<String>(
                  value: 'react native',
                  groupValue: _better,
                  onChanged: _onGenreChanged,
                ),
                const Text('React Native')
              ],
            ),
            const Divider(),
            const Text('¿Cuál es tu género favorito?'),
            // Mejor radio
            RadioListTile<String>(
              value: 'female',
              groupValue: _gender,
              contentPadding: EdgeInsets.zero,
              dense: true,
              visualDensity: VisualDensity.compact,
              title: const Text("Famale"),
              onChanged: (value) {
                setState(() {
                  _gender = value;
                });
              },
            ),
            RadioListTile<String>(
              value: 'male',
              groupValue: _gender,
              contentPadding: EdgeInsets.zero,
              dense: true,
              visualDensity: VisualDensity.compact,
              title: const Text("Male"),
              onChanged: (value) {
                setState(() {
                  _gender = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
