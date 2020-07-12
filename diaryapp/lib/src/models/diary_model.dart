import 'package:diaryapp/src/database/crud.dart';
import 'package:diaryapp/src/database/db_tables.dart';
import 'dart:convert';

Diary diaryFromJson(String str) => Diary.fromJson(json.decode(str));

String diaryToJson(Diary data) => json.encode(data.toJson());

class Diary extends Crud {
  int id;
  String type;
  String enterCode;

  Diary({this.id, this.type = '', this.enterCode = ''}) : super(DBTable.DIARY);

  factory Diary.fromJson(Map<String, dynamic> json) => Diary(
        id: json["id"],
        type: json["type"],
        enterCode: json["enter_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "enter_code": enterCode,
      };

  /* save() async {
    await insert(this.toJson());
  } */
}
