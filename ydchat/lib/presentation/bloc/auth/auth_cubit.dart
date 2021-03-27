import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ydchat/domain/usercases/get_current_uid.usercase.dart';
import 'package:ydchat/domain/usercases/is_sign_in_usercase.dart';
import 'package:ydchat/domain/usercases/sign_out_usercase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsSignInUserCase? isSignInUserCase;
  final GetCurrentUidUserCase? getCurrentUidUserCase;
  final SignOutUserCase? signOutUserCase;

  AuthCubit(
      {this.isSignInUserCase, this.getCurrentUidUserCase, this.signOutUserCase})
      : super(AuthInitial());

  Future<void> appStarted() async {
    try {
      bool isSignIn = await this.isSignInUserCase!.call();
      if (isSignIn) {
        final uid = await this.getCurrentUidUserCase!.call();
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } catch (e) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await this.getCurrentUidUserCase!.call();
      emit(Authenticated(uid: uid));
    } catch (e) {}
  }

  Future<void> loggedOut() async {
    try {
      await this.signOutUserCase!.call();
      emit(UnAuthenticated());
    } catch (e) {}
  }
}
