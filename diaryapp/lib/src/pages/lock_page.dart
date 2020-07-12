import 'package:diaryapp/src/bloc/diary_bloc.dart';
import 'package:diaryapp/src/bloc/provider.dart';
import 'package:diaryapp/src/models/diary_model.dart';
import 'package:flutter/material.dart';

class LockPage extends StatefulWidget {
  const LockPage({Key key}) : super(key: key);

  @override
  _LockPageState createState() => _LockPageState();
}

class _LockPageState extends State<LockPage> {
  @override
  Widget build(BuildContext context) {
    final _diariesBloc = Provider.diaryBloc(context);
    _diariesBloc.loadData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Diaries'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).accentColor,
          onPressed: () {}),
      body: _createDiaries(_diariesBloc),
    );
  }

  Widget _createDiaries(DiaryBloc diaryBloc) {
    return StreamBuilder(
      stream: diaryBloc.diaryStream,
      builder: (BuildContext context, AsyncSnapshot<List<Diary>> snapshot) {
        if (snapshot.hasData) {
          final diaries = snapshot.data;
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: diaries.length,
            itemBuilder: (BuildContext context, int index) =>
                _createItem(context, diaries[index]),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  _createItem(BuildContext context, Diary diari) {
    return ListTile(
      leading: CircleAvatar(
        child: Text('${diari.id}'),
      ),
      title: Text('${diari.type}'),
      subtitle: Text('${diari.enterCode}'),
    );
  }
}
