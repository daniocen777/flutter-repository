import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoCalendarPage extends StatefulWidget {
  const CupertinoCalendarPage({super.key});

  @override
  State<CupertinoCalendarPage> createState() => _CupertinoCalendarPageState();
}

class _CupertinoCalendarPageState extends State<CupertinoCalendarPage> {
  late DateTime _date;

  @override
  void initState() {
    super.initState();
    _date = DateTime(2021);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save_as),
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 200.0,
            // CupertinoDatePicker => necesita un tamaño
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: _date,
              minimumDate: DateTime(1920),
              maximumDate: DateTime.now(),
              onDateTimeChanged: (dateTime) {
                setState(() {
                  _date = dateTime;
                });
              },
            ),
          ),
        ],
      )),
    );
  }
}
