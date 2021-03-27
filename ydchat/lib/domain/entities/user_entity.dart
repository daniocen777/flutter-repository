import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final bool? isOnline;
  final String? status;
  final String? profielUrl;

  UserEntity(
      {this.uid,
      this.name,
      this.email,
      this.phoneNumber,
      this.isOnline,
      this.status = 'Estoy usando esta app',
      this.profielUrl});

  @override
  List<Object?> get props =>
      [uid, name, email, phoneNumber, isOnline, status, profielUrl];
}
