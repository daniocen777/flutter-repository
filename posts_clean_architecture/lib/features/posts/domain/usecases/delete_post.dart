import 'package:dartz/dartz.dart';

import 'package:posts_clean_architecture/core/errors/failures.dart';

import '../repositories/posts_repository.dart';

class DeletePostUsecase {
  final PostsRepository repository;

  DeletePostUsecase(this.repository);

  Future<Either<Failure, Unit>> call(int postId) async {
    return await repository.deletePost(postId);
  }
}
