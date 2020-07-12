import 'package:diaryapp/src/bloc/diary_bloc.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  final _diaryBloc = new DiaryBloc();

  static Provider _instancia;

  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child);
    }

    return _instancia;
  }

  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  static DiaryBloc diaryBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>()._diaryBloc);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
