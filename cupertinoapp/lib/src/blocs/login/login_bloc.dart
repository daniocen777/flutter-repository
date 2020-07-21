import 'package:bloc/bloc.dart';
import 'package:cupertinoapp/src/api/account_api.dart';
import 'package:cupertinoapp/src/blocs/login/login_events.dart';
import 'package:cupertinoapp/src/blocs/login/login_state.dart';
import 'package:cupertinoapp/src/pages/home_page.dart';
import 'package:cupertinoapp/src/utils/dialogs.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  AccountApi _accountApi = AccountApi();

  @override
  LoginState get initialState => LoginState();

  @override
  Stream<LoginState> mapEventToState(LoginEvents event) async* {
    if (event is LoginByPassword) {
      yield* _submitByPassword(event);
    } else if (event is LoginByFacebook) {
    } else if (event is LoginByGoogle) {}
  }

  Stream<LoginState> _submitByPassword(LoginByPassword event) async* {
    yield this.state.copyWith(fetching: true);

    bool isOk = await _accountApi.login(event.email, event.password);
    if (isOk) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('wasLogin', true);
      Navigator.pushReplacementNamed(event.context, HomePage.routename);
    } else {
      final intents = this.state.intents + 1;
      yield this
          .state
          .copyWith(fetching: false, intents: (intents == 3) ? 0 : intents);

      await Dialogs.alert(event.context,
          title: 'Error',
          body: (intents == 3)
              ? 'Se hga enviado una alerta al correo ${event.email}'
              : 'Email y/o contraseña incorrectos');
    }
  }
}
