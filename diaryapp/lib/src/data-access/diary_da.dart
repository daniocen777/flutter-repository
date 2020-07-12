import 'package:diaryapp/src/database/crud.dart';
import 'package:diaryapp/src/database/db_tables.dart';
import 'package:diaryapp/src/models/diary_model.dart';

class DiaryDataAccess {
  final _crud = Crud(DBTable.DIARY);

  Future<List<Diary>> loadData() async {
    final result = await _crud.query();
    List<Diary> diaries = new List();
    for (var i = 0; i < result.length; i++) {
      diaries.add(Diary.fromJson(result[i]));
    }

    return diaries;
  }

  Future<int> save(Diary diary) async {
    final result = await _crud.insert(diary.toJson());
    return (result > 0) ? result : 0;
  }

  Future<int> update(Diary diary) async {
    final result = await _crud.update(diary.toJson());
    return (result > 0) ? result : 0;
  }

  Future<int> delete(int id) async {
    final result = await _crud.delete(id);
    return (result > 0) ? result : 0;
  }
}
