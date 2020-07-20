import 'package:bloc/bloc.dart';
import 'package:cupertinoapp/src/blocs/login/login_events.dart';
import 'package:cupertinoapp/src/blocs/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  @override
  LoginState get initialState => LoginState();

  @override
  Stream<LoginState> mapEventToState(LoginEvents event) async* {
    if (event is LoginByPassword) {
    } else if (event is LoginByFacebook) {
    } else if (event is LoginByGoogle) {}
  }
}
