import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ydchat/domain/entities/user_entity.dart';
import 'package:ydchat/domain/usercases/create_current_user.usercase.dart';
import 'package:ydchat/domain/usercases/sign_in_with_phone_number_usercase.dart';
import 'package:ydchat/domain/usercases/verify_phone_number_usercase.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  final SignInWithPhoneNumberUserCase? signInWithPhoneNumberUserCase;
  final VerifyPhoneNumberUserCase? verifyPhoneNumberUserCase;
  final CreateCurrentUserUserCase? createCurrentUserUserCase;

  PhoneAuthCubit(
      {this.signInWithPhoneNumberUserCase,
      this.verifyPhoneNumberUserCase,
      this.createCurrentUserUserCase})
      : super(PhoneAuthInitial());

  Future<void> submitVerifyPhoneNumber(String phoneNumber) async {
    emit(PhoneAuthLoading());
    try {
      await this.verifyPhoneNumberUserCase!.call(phoneNumber);
      emit(PhoneAuthSmsCodeReceived());
    } on SocketException catch (_) {
      emit(PhoneAuthFailure());
    } catch (e) {
      emit(PhoneAuthFailure());
    }
  }

  Future<void> submitSmsCode(String smsPinCode) async {
    try {
      await this.signInWithPhoneNumberUserCase!.call(smsPinCode);
      emit(PhoneAuthProfileInfo());
    } on SocketException catch (_) {
      emit(PhoneAuthFailure());
    } catch (e) {
      emit(PhoneAuthFailure());
    }
  }

  Future<void> submitProfileInfo(
      {String? name, String? profileUrl, String? phoneNumber}) async {
    try {
      await this.createCurrentUserUserCase!.call(UserEntity(
          uid: '',
          name: name,
          email: '',
          phoneNumber: phoneNumber,
          isOnline: true,
          profielUrl: profileUrl,
          status: ''));
          print('*******************************************************************');
          print('submitProfileInfo');
          print('*******************************************************************');
      emit(PhoneAuthSuccess());
    } on SocketException catch (_) {
      emit(PhoneAuthFailure());
    } catch (e) {
      emit(PhoneAuthFailure());
    }
  }
}
