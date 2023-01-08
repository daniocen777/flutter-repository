import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/core/errors/failures.dart';
import 'package:posts_clean_architecture/features/posts/domain/entities/post.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();

  Future<Either<Failure, Unit>> addPost(Post post);

  Future<Either<Failure, Unit>> deletePost(int postId);

  Future<Either<Failure, Unit>> updatePost(Post post);
}
