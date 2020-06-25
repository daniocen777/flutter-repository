import 'package:flutter/material.dart';
import 'package:login_bloc/src/bloc/login_bloc.dart';
export 'package:login_bloc/src/bloc/login_bloc.dart';

/* InheritedWidget para enviar o recibir información desde el padre */
class Provider extends InheritedWidget {
  final loginBloc = LoginBloc();
  final Widget child;

  Provider({Key key, this.child}) : super(key: key, child: child);

  static LoginBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc);
  }

  // Notificar a los hijos
  @override
  bool updateShouldNotify(Provider oldWidget) {
    return true;
  }
}
