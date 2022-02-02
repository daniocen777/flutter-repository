import 'package:authapp/app/ui/pages/register/controller/register_state.dart';
import 'package:flutter_meedu/meedu.dart';

/* Usando StateNorifier (similar a Bloc) */
// ver: https://flutter.meedu.app/docs/5.x.x/state-management/state-notifier
class RegisterController extends StateNotifier<RegisterState> {
  RegisterController() : super(RegisterState.initialState);

  void submit() {
    
  }
}
