import 'package:dartz/dartz.dart';

import 'package:posts_clean_architecture/core/errors/failures.dart';

import '../entities/post.dart';
import '../repositories/posts_repository.dart';

class AddPostUsecase {
  final PostsRepository repository;

  AddPostUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.addPost(post);
  }
}
