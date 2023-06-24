import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({super.key});

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _value = 0;
  double _value2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Slider(
              value: _value2,
              label: '$_value2',
              min: 0,
              max: 10,
              divisions: 10,
              onChanged: (value) {
                setState(() {
                  _value2 = value.floorToDouble(); // tranformar a entero
                });
              },
            ),
            // Slider vertical
            Row(
              children: [
                const SizedBox(width: 30.0),
                SizedBox(
                  height: 300.0,
                  child: RotatedBox(
                    quarterTurns: 3, // proibar 1, 2, 3
                    child: Slider(
                      value: _value,
                      label: '$_value',
                      min: 0,
                      max: 100,
                      divisions: 100,
                      onChanged: (value) {
                        setState(() {
                          _value = value.floorToDouble(); // tranformar a entero
                        });
                      },
                    ),
                  ),
                ),
                const Text('Volumen')
              ],
            ),
          ],
        ),
      )),
    );
  }
}
