import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// localizador de objetos
import 'package:get_it/get_it.dart';

import 'package:ydchat/data/datasource/firebase_remote_datasource.dart';
import 'package:ydchat/data/datasource/firebase_remote_datasource_impl.dart';
import 'package:ydchat/data/repositories/firebase_repository_imp.dart';
import 'package:ydchat/domain/repositories/firebase_repository.dart';
import 'package:ydchat/domain/usercases/add_to_my_chat_usecase.dart';
import 'package:ydchat/domain/usercases/create_current_user.usercase.dart';
import 'package:ydchat/domain/usercases/create_one_to_one_chat_channel_usecase.dart';
import 'package:ydchat/domain/usercases/get_all_users_usecase.dart';
import 'package:ydchat/domain/usercases/get_current_uid.usercase.dart';
import 'package:ydchat/domain/usercases/get_my_chat_usecase.dart';
import 'package:ydchat/domain/usercases/get_one_to_one_single_user_channel_id_usecase.dart';
import 'package:ydchat/domain/usercases/get_text_messages_usecase.dart';
import 'package:ydchat/domain/usercases/is_sign_in_usercase.dart';
import 'package:ydchat/domain/usercases/send_text_message_usecase.dart';
import 'package:ydchat/domain/usercases/sign_in_with_phone_number_usercase.dart';
import 'package:ydchat/domain/usercases/sign_out_usercase.dart';
import 'package:ydchat/domain/usercases/verify_phone_number_usercase.dart';
import 'package:ydchat/presentation/bloc/auth/auth_cubit.dart';
import 'package:ydchat/presentation/bloc/phone_auth/phone_auth_cubit.dart';

final sl = GetIt.instance;

/* 34:25 */

/* Llamar a este método cuando el app inicie */
Future<void> init() async {
  /* Bloc */
  sl.registerLazySingleton<PhoneAuthCubit>(() => PhoneAuthCubit(
      createCurrentUserUserCase: sl.call(),
      signInWithPhoneNumberUserCase: sl.call(),
      verifyPhoneNumberUserCase: sl.call()));

  sl.registerLazySingleton<AuthCubit>(() => AuthCubit(
      signOutUserCase: sl.call(),
      isSignInUserCase: sl.call(),
      getCurrentUidUserCase: sl.call()));

  /* Casos de uso */
  // Autenticación
  sl.registerLazySingleton<CreateCurrentUserUserCase>(
      () => CreateCurrentUserUserCase(firebaseRepository: sl.call()));

  sl.registerLazySingleton<GetCurrentUidUserCase>(
      () => GetCurrentUidUserCase(firebaseRepository: sl.call()));

  sl.registerLazySingleton<IsSignInUserCase>(
      () => IsSignInUserCase(firebaseRepository: sl.call()));

  sl.registerLazySingleton<SignInWithPhoneNumberUserCase>(
      () => SignInWithPhoneNumberUserCase(firebaseRepository: sl.call()));

  sl.registerLazySingleton<SignOutUserCase>(
      () => SignOutUserCase(firebaseRepository: sl.call()));

  sl.registerLazySingleton<VerifyPhoneNumberUserCase>(
      () => VerifyPhoneNumberUserCase(firebaseRepository: sl.call()));

  // Mensajes
  sl.registerLazySingleton<GetAllUsersUseCase>(
      () => GetAllUsersUseCase(firebaseRepository: sl.call()));

  sl.registerLazySingleton<GetMyChatUseCase>(
      () => GetMyChatUseCase(firebaseRepository: sl.call()));

  sl.registerLazySingleton<GetTextMessagesUseCase>(
      () => GetTextMessagesUseCase(firebaseRepository: sl.call()));

  sl.registerLazySingleton<SendTextMessageUseCase>(
      () => SendTextMessageUseCase(firebaseRepository: sl.call()));

  sl.registerLazySingleton<AddToMyChatUseCase>(
      () => AddToMyChatUseCase(firebaseRepository: sl.call()));

  sl.registerLazySingleton<CreateOneToOneChatChannelUseCase>(
      () => CreateOneToOneChatChannelUseCase(firebaseRepository: sl.call()));

  sl.registerLazySingleton<GetOneToOneSingleUserChannelIdUseCase>(() =>
      GetOneToOneSingleUserChannelIdUseCase(firebaseRepository: sl.call()));


  /* Repositorios */
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(firebaseRemoteDataSource: sl.call()));

  /* Data remota */
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(auth: sl.call(), fireStore: sl.call()));

  /* Externo */
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
}
