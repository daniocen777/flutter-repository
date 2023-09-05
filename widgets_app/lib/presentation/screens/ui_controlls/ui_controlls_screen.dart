import 'package:flutter/material.dart';

class UIControllsScreen extends StatelessWidget {
  const UIControllsScreen({super.key});

  static const name = 'ui_controlls_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Controls'),
      ),
      body: const _UIControlsView(),
    );
  }
}

class _UIControlsView extends StatefulWidget {
  const _UIControlsView();

  @override
  State<_UIControlsView> createState() => _UIControlsViewState();
}

enum Transportation { car, plane, boat, submarine }

class _UIControlsViewState extends State<_UIControlsView> {
  bool isDeveloper = true;
  bool wantsBreakfast = false;
  bool wantsLounche = false;
  bool wantsDinner = false;
  Transportation selectedTransportation = Transportation.car;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SwitchListTile(
          title: const Text('Developer mode'),
          subtitle: const Text('Controles adicionales'),
          value: isDeveloper,
          onChanged: (value) => setState(() {
            isDeveloper = !isDeveloper;
          }),
        ),
        //
        ExpansionTile(
          title: const Text('Vehículo de tranporte'),
          subtitle: Text('$selectedTransportation'),
          children: [
            RadioListTile(
              value: Transportation.car,
              title: const Text('By car'),
              subtitle: const Text('Viajar por carro'),
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.car;
              }),
            ),
            RadioListTile(
              value: Transportation.boat,
              title: const Text('By boat'),
              subtitle: const Text('Viajar por barco'),
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.boat;
              }),
            ),
            RadioListTile(
              value: Transportation.plane,
              title: const Text('By plane'),
              subtitle: const Text('Viajar por avión'),
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.plane;
              }),
            ),
            RadioListTile(
              value: Transportation.submarine,
              title: const Text('By submarine'),
              subtitle: const Text('Viajar por submarino'),
              groupValue: selectedTransportation,
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.submarine;
              }),
            ),
          ],
        ),
        //
        CheckboxListTile(
          value: wantsBreakfast,
          title: const Text('¿Desayuno?'),
          onChanged: (value) => setState(() {
            wantsBreakfast = !wantsBreakfast;
          }),
        ),
        CheckboxListTile(
          value: wantsBreakfast,
          title: const Text('Almuerzo?'),
          onChanged: (value) => setState(() {
            wantsLounche = !wantsLounche;
          }),
        ),
        CheckboxListTile(
          value: wantsBreakfast,
          title: const Text('Cena?'),
          onChanged: (value) => setState(() {
            wantsDinner = !wantsDinner;
          }),
        ),
      ],
    );
  }
}
