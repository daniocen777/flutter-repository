import 'package:ydchat/domain/entities/user_entity.dart';
import 'package:ydchat/domain/repositories/firebase_repository.dart';

class GetAllUsersUseCase {
  final FirebaseRepository? firebaseRepository;

  GetAllUsersUseCase({this.firebaseRepository});

  Stream<List<UserEntity>> call() {
    return this.firebaseRepository!.getAllUsers();
  }
}
