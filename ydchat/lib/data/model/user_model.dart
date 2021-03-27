import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ydchat/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {String? uid,
      String? name,
      String? email,
      String? phoneNumber,
      bool? isOnline,
      String? status,
      String? profielUrl})
      : super(
            uid: uid,
            name: name,
            email: email,
            phoneNumber: phoneNumber,
            isOnline: isOnline,
            status: status,
            profielUrl: profielUrl);

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
        uid: snapshot.data()?['uid'],
        name: snapshot.data()?['name'],
        email: snapshot.data()?['email'],
        phoneNumber: snapshot.data()?['phoneNumber'],
        isOnline: snapshot.data()?['isOnline'],
        status: snapshot.data()?['status'],
        profielUrl: snapshot.data()?['profielUrl']);
  }

  Map<String, dynamic> toDocument() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'isOnline': isOnline,
      'status': status,
      'profielUrl': profielUrl
    };
  }
}
