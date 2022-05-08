import 'dart:convert';

Student studentFromJson(String str) => Student.fromJson(json.decode(str));

String studentToJson(Student data) => json.encode(data.toJson());

class Student {
  Student({
    required this.dni,
    required this.name,
    required this.hours,
    required this.minutes,
    required this.credits,
  });

  String dni;
  String name;
  int hours;
  int minutes;
  int credits;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        dni: json["dni"],
        name: json["name"],
        hours: json["hours"],
        minutes: json["minutes"],
        credits: json["credits"],
      );

  Map<String, dynamic> toJson() => {
        "dni": dni,
        "name": name,
        "hours": hours,
        "minutes": minutes,
        "credits": credits,
      };
}
