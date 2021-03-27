import 'package:ydchat/domain/entities/user_entity.dart';
import 'package:ydchat/domain/repositories/firebase_repository.dart';

class CreateCurrentUserUserCase {
  final FirebaseRepository? firebaseRepository;

  CreateCurrentUserUserCase({this.firebaseRepository});

  Future<void> call(UserEntity userEntity) async {
    return await this.firebaseRepository!.createCurrentUser(userEntity);
  }
}
