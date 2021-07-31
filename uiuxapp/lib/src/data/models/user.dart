class User {
  final String id;
  final String email;
  final String name;
  final String lastname;
  final String password;
  final DateTime birthday;

  User(
      {required this.id,
      required this.email,
      required this.name,
      required this.lastname,
      required this.password,
      required this.birthday});
}
