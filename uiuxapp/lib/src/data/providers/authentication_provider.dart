import '../models/user.dart';

class AuthenticationProvider {

  Future<User?> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 3));
    if (email == 'test@test.com' && password == 'test') {
      return User(
          id: '123456',
          email: 'email',
          name: 'test',
          lastname: 'Mendoza',
          password: '123456',
          birthday: DateTime(1989, 2, 13));
    }

    return null;
  }
}
