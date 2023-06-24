import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _initialDate, _date;

  @override
  void initState() {
    super.initState();
    _initialDate = DateTime(1993, 4, 10);
    _date = _initialDate;
    // evitar conflicto del selectableDayPredicate
    while (!_selectableDayPredicate(_initialDate)) {
      _initialDate = _initialDate.add(const Duration(days: 1));
      _date = _initialDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _save,
            icon: const Icon(Icons.save),
          ),
          IconButton(
            onPressed: _selectTime,
            icon: const Icon(Icons.watch),
          ),
          IconButton(
            onPressed: _selectDate,
            icon: const Icon(Icons.calendar_month_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: CalendarDatePicker(
          initialDate: _date, // fecha inicial seleccionada
          firstDate:
              DateTime(1900, 5), // fecha inicial del calendario (mayo de 1990)
          lastDate: DateTime.now(), // fecha final del calendario
          initialCalendarMode: DatePickerMode.year,
          // tener cuidado con initialDate (no debe caer en ña condición del retun)
          selectableDayPredicate: _selectableDayPredicate,
          onDateChanged: (dateTime) {
            _date = dateTime;
          },
        ),
      ),
    );
  }

  bool _selectableDayPredicate(DateTime dateTime) {
    return dateTime.weekday != 6 &&
        dateTime.weekday != 7; // QUitar los días sábados y domingos
  }

  void _save() {
    if (_initialDate != _date) {}
    Navigator.pop(context);
  }

  Future<void> _selectDate() async {
    final dateTime = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate:
          DateTime(1900, 5), // fecha inicial del calendario (mayo de 1990)
      lastDate: DateTime.now(), // fecha final del calendario
      initialEntryMode: DatePickerEntryMode.input,
      cancelText: 'Cancelar',
      confirmText: "Aceptar",
    );

    if (dateTime != null) {
      setState(() {
        _date = dateTime;
      });
    }
  }

  Future<void> _selectTime() async {
    final timeOfDay = await showTimePicker(
      context: context,
      // Para no minimizar dialog
      builder: (_, child) {
        return WillPopScope(child: child!, onWillPop: () async => false);
      },
      initialTime: const TimeOfDay(hour: 0, minute: 0),
    );

    if (timeOfDay != null) {
      print(timeOfDay);
    }
  }
}
