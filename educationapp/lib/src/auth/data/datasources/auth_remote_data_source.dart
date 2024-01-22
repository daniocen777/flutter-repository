import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educationapp/core/enums/update_user.dart';
import 'package:educationapp/core/errors/exceptions.dart';
import 'package:educationapp/core/utils/constants.dart';
import 'package:educationapp/core/utils/typedef.dart';
import 'package:educationapp/src/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();
  Future<void> forgotPassword(String email);
  // LocalUserMode => StudentModel || TeacherModel
  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String fullname,
    required String password,
  });

  Future<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  })  : _firebaseAuth = firebaseAuth,
        _firestore = firestore,
        _storage = storage;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Ocurred',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;
      if (user == null) {
        throw const ServerException(
          message: 'Please, try again later',
          statusCode: 'Unknown Error',
        );
      }
      var userData = await _getUserData(user.uid);
      if (userData.exists) {
        return LocalUserModel.fromMap(userData.data()!);
      }
      // Upload user
      await _setUserData(user, email);
      userData = await _getUserData(user.uid);
      return LocalUserModel.fromMap(userData.data()!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Ocurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> signUp({
    required String email,
    required String fullname,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName(fullname);
      // Actualizar foto por una por defecto
      await userCredential.user?.updatePhotoURL(kDefaultAvatar);
      // Actualizar
      await _setUserData(_firebaseAuth.currentUser!, email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Ocurred',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  }) async {
    try {
      switch (action) {
        case UpdateUserAction.email:
          await _firebaseAuth.currentUser?.updateEmail(userData as String);
          await _updateUserData({'email': userData});
        case UpdateUserAction.displayName:
          await _firebaseAuth.currentUser
              ?.updateDisplayName(userData as String);
          await _updateUserData({'fullName': userData});
        case UpdateUserAction.profilePic:
          final reference = _storage
              .ref()
              .child('profile_pics/${_firebaseAuth.currentUser?.uid}');
          await reference.putFile(userData as File);
          final url = await reference.getDownloadURL();
          await _firebaseAuth.currentUser?.updatePhotoURL(url);
          await _updateUserData({'profilePic': url});
        case UpdateUserAction.password:
          if (_firebaseAuth.currentUser?.email == null) {
            throw const ServerException(
              message: 'User does not existe',
              statusCode: 'Insufficient Permission',
            );
          }
          final newData = jsonDecode(userData as String) as DataMap;
          await _firebaseAuth.currentUser?.reauthenticateWithCredential(
            EmailAuthProvider.credential(
              email: _firebaseAuth.currentUser!.email!,
              password: newData['oldPassword']! as String,
            ),
          );

          await _firebaseAuth.currentUser
              ?.updatePassword(newData['newPassword'] as String);

        case UpdateUserAction.bio:
          await _updateUserData({'bio': userData as String});
      }
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Ocurred',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  Future<DocumentSnapshot<DataMap>> _getUserData(String uid) async {
    return _firestore.collection('users').doc(uid).get();
  }

  Future<void> _setUserData(User user, String fallbackEmail) async {
    // fallbackEmail => correo alternativo
    await _firestore.collection('users').doc(user.uid).set(
          LocalUserModel(
            uid: user.uid,
            email: user.email ?? fallbackEmail,
            profilePic: user.photoURL ?? '',
            bio: user.displayName ?? '',
            points: 0,
            fullname: user.displayName ?? '',
          ).toMap(),
        );
  }

  Future<void> _updateUserData(DataMap data) async {
    await _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser?.uid)
        .update(data);
  }
}
