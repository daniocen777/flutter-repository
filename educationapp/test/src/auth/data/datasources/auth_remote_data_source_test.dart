import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educationapp/core/enums/update_user.dart';
import 'package:educationapp/core/errors/exceptions.dart';
import 'package:educationapp/core/utils/constants.dart';
import 'package:educationapp/core/utils/typedef.dart';
import 'package:educationapp/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:educationapp/src/auth/data/models/user_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

// Usar los paquetes para pruebas (ver pubspect en dependencias de desarrollo)
// => FakeFirebaseFirestore & MockFirebaseStorage
/* class MockFirebaseStorage extends Mock implements FirebaseStorage {}
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {} */

// Para la respuesta de firebase
class MockUser extends Mock implements User {
  String _uid = 'Test uid';

  @override
  String get uid => _uid;

  set uid(String value) {
    if (_uid != value) _uid = value;
  }
}

class MockUserCredential extends Mock implements UserCredential {
  MockUserCredential([User? user]) : _user = user;
  User? _user;

  @override
  User? get user => _user;

  set user(User? value) {
    if (_user != value) _user = value;
  }
}

// Para el test de actuazliar password
class MockAuthCredential extends Mock implements AuthCredential {}

void main() {
  late FirebaseAuth firebaseAuth;
  late FirebaseFirestore firestore;
  late MockFirebaseStorage storage;
  late AuthRemoteDataSource dataSource;
  late MockUser mockUser;
  late UserCredential userCredential;
  late DocumentReference<DataMap> documentReference;
  const testUser = LocalUserModel.empty();

  setUpAll(() async {
    firebaseAuth = MockFirebaseAuth();
    firestore = FakeFirebaseFirestore();
    // Agregando un usuario falso
    documentReference = firestore.collection('users').doc();
    await documentReference
        .set(testUser.copiWith(uid: documentReference.id).toMap());
    mockUser = MockUser()..uid = documentReference.id;
    storage = MockFirebaseStorage();
    userCredential = MockUserCredential(mockUser);
    dataSource = AuthRemoteDataSourceImpl(
      firebaseAuth: firebaseAuth,
      firestore: firestore,
      storage: storage,
    );
    // Siempre que se llame a currentUser, debe devolver  usuario falso creado
    when(() => firebaseAuth.currentUser).thenReturn(mockUser);
  });

  // Datos de prueba
  const tEmail = 'test_email@mail.com';
  const tPassword = 'Test Password';
  const tFullname = 'Test Fullname';
  final tFirebaseAuthException = FirebaseAuthException(
    code: 'user-not-found',
    message: 'There is no user record corresponding to this identifier.',
  );

  group('forgotPassword', () {
    test(
      'debe completar correctamente cuando no se lance [Exception]',
      () async {
        // Arrange
        when(
          () => firebaseAuth.sendPasswordResetEmail(email: any(named: 'email')),
        ).thenAnswer((_) async => Future.value);
        // Act
        final call = dataSource.forgotPassword(tEmail);
        // Assert
        expect(call, completes);
        verify(() => firebaseAuth.sendPasswordResetEmail(email: tEmail))
            .called(1);
        verifyNoMoreInteractions(firebaseAuth);
      },
    );

    test(
      'debe lanzar [ServerException] cuando se devuelva [FirebaseAuthException]',
      () async {
        // Arrange
        when(
          () => firebaseAuth.sendPasswordResetEmail(email: any(named: 'email')),
        ).thenThrow(tFirebaseAuthException);
        // Act
        final call = dataSource.forgotPassword;
        // Assert
        expect(() => call(tEmail), throwsA(isA<ServerException>()));
        verify(() => firebaseAuth.sendPasswordResetEmail(email: tEmail))
            .called(1);
        verifyNoMoreInteractions(firebaseAuth);
      },
    );
  });

  group('signIn', () {
    test(
      'debe retornar [LocalUserModel] cuando no se lance [Exception]',
      () async {
        // Arrange
        when(
          () => firebaseAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => userCredential);
        // Act
        final result =
            await dataSource.signIn(email: tEmail, password: tPassword);
        // Assert
        expect(result.uid, userCredential.user!.uid);
        expect(result.points, 0);
        verify(
          () => firebaseAuth.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(firebaseAuth);
      },
    );

    test(
      'debe lanzar [ServerException] cuando el usuario sea null '
      'luego de ejecutar la función signIn',
      () async {
        // Arrange
        final emptyUserCredential = MockUserCredential();
        when(
          () => firebaseAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => emptyUserCredential);
        // Act
        final call = dataSource.signIn;
        // Assert
        expect(
          () => call(email: tEmail, password: tPassword),
          throwsA(isA<ServerException>()),
        );
        verify(
          () => firebaseAuth.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(firebaseAuth);
      },
    );

    test(
      'debe lanzar [ServerException] cuando haya un [FirebaseAuthException]',
      () async {
        // Arrange
        when(
          () => firebaseAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(tFirebaseAuthException);
        // Act
        final call = dataSource.signIn;
        // Assert
        expect(
          () => call(email: tEmail, password: tPassword),
          throwsA(isA<ServerException>()),
        );
        verify(
          () => firebaseAuth.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(firebaseAuth);
      },
    );
  });

  group('signUp', () {
    test(
      'debe ejecutarse correctamente y no lanzar un [Exception]',
      () async {
        // Arrange
        when(
          () => firebaseAuth.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => userCredential);
        // Se agrega, ya que signUp actualiza displayName y photoUrl (ver implementación)
        when(() => userCredential.user?.updateDisplayName(any()))
            .thenAnswer((_) async => Future.value());
        when(() => userCredential.user?.updatePhotoURL(any()))
            .thenAnswer((_) async => Future.value());
        // Act
        final call = dataSource.signUp(
          email: tEmail,
          fullname: tFullname,
          password: tPassword,
        );
        // Assert
        expect(call, completes);
        verify(
          () => firebaseAuth.createUserWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        // Verificar que se haya ejecutado (await)
        await untilCalled(() => userCredential.user?.updateDisplayName(any()));
        await untilCalled(() => userCredential.user?.updatePhotoURL(any()));
        verify(() => userCredential.user?.updateDisplayName(tFullname))
            .called(1);
        verify(() => userCredential.user?.updatePhotoURL(kDefaultAvatar))
            .called(1);
        verifyNoMoreInteractions(firebaseAuth);
      },
    );

    test(
      'debe lanzar [ServerException] cuando haya un [FirebaseAuthException]',
      () async {
        // Arrange
        when(
          () => firebaseAuth.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(tFirebaseAuthException);
        // Act
        final call = dataSource.signUp;
        // Assert
        expect(
          () => call(email: tEmail, password: tPassword, fullname: tFullname),
          throwsA(isA<ServerException>()),
        );
        verify(
          () => firebaseAuth.createUserWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        // verifyNoMoreInteractions(firebaseAuth);
      },
    );
  });

  group('updateUser', () {
    // Registrar función remota (Para actualizar password)
    setUp(() {
      registerFallbackValue(MockAuthCredential());
    });

    test(
      'debe actualizar displayName correctamente sin lanzar [Exception]',
      () async {
        // Arrange
        when(() => mockUser.updateDisplayName(any()))
            .thenAnswer((_) async => Future.value());
        // Act
        await dataSource.updateUser(
          action: UpdateUserAction.displayName,
          userData: tFullname,
        );
        // Assert
        verify(() => mockUser.updateDisplayName(tFullname)).called(1);
        // No verificar los demas campos (solo displayName)
        verifyNever(() => mockUser.updateEmail(any()));
        verifyNever(() => mockUser.updatePhotoURL(any()));
        verifyNever(() => mockUser.updatePassword(any()));

        final userData =
            await firestore.collection('users').doc(mockUser.uid).get();
        expect(userData.data()!['fullName'], tFullname);
      },
    );

    test(
      'debe actualizar email correctamente sin lanzar [Exception]',
      () async {
        // Arrange
        when(() => mockUser.updateEmail(any()))
            .thenAnswer((_) async => Future.value());
        // Act
        await dataSource.updateUser(
          action: UpdateUserAction.email,
          userData: tEmail,
        );
        // Assert
        verify(() => mockUser.updateEmail(tEmail)).called(1);
        // No verificar los demas campos
        verifyNever(() => mockUser.updateDisplayName(any()));
        verifyNever(() => mockUser.updatePhotoURL(any()));
        verifyNever(() => mockUser.updatePassword(any()));

        final userData =
            await firestore.collection('users').doc(mockUser.uid).get();
        expect(userData.data()!['email'], tEmail);
      },
    );

    test(
      'debe actualizar bio correctamente sin lanzar [Exception]',
      () async {
        // Arrange
        const newBio = 'New Bio';
        await dataSource.updateUser(
          action: UpdateUserAction.bio,
          userData: newBio,
        );
        // Assert
        final userData =
            await firestore.collection('users').doc(mockUser.uid).get();
        expect(userData.data()!['bio'], newBio);
        // No verificar los demas campos
        verifyNever(() => mockUser.updateDisplayName(any()));
        verifyNever(() => mockUser.updatePhotoURL(any()));
        verifyNever(() => mockUser.updateEmail(any()));
        verifyNever(() => mockUser.updatePassword(any()));
      },
    );

    test(
      'debe actualizar password correctamente sin lanzar [Exception]',
      () async {
        // Arrange
        when(() => mockUser.updatePassword(any()))
            .thenAnswer((_) async => Future.value());
        // reauthenticateWithCredential
        when(() => mockUser.reauthenticateWithCredential(any()))
            .thenAnswer((_) async => userCredential);
        when(() => mockUser.email).thenReturn(tEmail);

        // Act
        await dataSource.updateUser(
          action: UpdateUserAction.password,
          userData: jsonEncode(
            {'oldPassword': 'oldPassword', 'newPassword': tPassword},
          ),
        );
        // Assert
        verify(() => mockUser.updatePassword(tPassword));
        // No verificar los demas campos (solo displayName)
        verifyNever(() => mockUser.updateDisplayName(any()));
        verifyNever(() => mockUser.updatePhotoURL(any()));
        verifyNever(() => mockUser.updateEmail(any()));

        final userData =
            await firestore.collection('users').doc(mockUser.uid).get();
        expect(userData.data()!['password'], null);
      },
    );

    test(
      'debe actualizar profilePic correctamente sin lanzar [Exception]',
      () async {
        // Arrange
        final newProfilePic =
            File('assets/images/on_boarding_background_2.jpg');
        when(() => mockUser.updatePhotoURL(any()))
            .thenAnswer((_) async => Future.value());
        // Act
        await dataSource.updateUser(
          action: UpdateUserAction.profilePic,
          userData: newProfilePic,
        );
        // Assert
        verify(() => mockUser.updatePhotoURL(any())).called(1);

        verifyNever(() => mockUser.updateDisplayName(any()));
        verifyNever(() => mockUser.updatePassword(any()));
        verifyNever(() => mockUser.updateEmail(any()));

        // Debe existir en storage
        expect(storage.storedFilesMap.isNotEmpty, isTrue);
      },
    );
  });
}
