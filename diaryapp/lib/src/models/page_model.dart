import 'dart:convert';

import 'package:diaryapp/src/database/crud.dart';
import 'package:diaryapp/src/database/db_tables.dart';

Page pageFromJson(String str) => Page.fromJson(json.decode(str));

String pageToJson(Page data) => json.encode(data.toJson());

class Page extends Crud {
  int id;
  String date;
  String title;
  String content;
  int diaryId;

  Page({
    this.id,
    this.date,
    this.title,
    this.content,
    this.diaryId,
  }) : super(DBTable.PAGE);

  factory Page.fromJson(Map<String, dynamic> json) => Page(
        id: json["id"],
        date: json["date"],
        title: json["title"],
        content: json["content"],
        diaryId: json["diary_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "title": title,
        "content": content,
        "diary_id": diaryId,
      };
}
