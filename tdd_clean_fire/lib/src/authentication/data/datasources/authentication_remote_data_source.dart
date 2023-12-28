import '../models/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser(
      {required String createdAt, required String name, required String avatar});

  // En los datasources, siempre se devuelven los modelos
  Future<List<UserModel>> getUsers();
}
