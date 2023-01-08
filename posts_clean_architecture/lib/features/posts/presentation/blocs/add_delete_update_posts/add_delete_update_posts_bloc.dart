import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_clean_architecture/core/errors/failures.dart';
import 'package:posts_clean_architecture/core/strings/failures.dart';
import 'package:posts_clean_architecture/core/strings/messages.dart';
import 'package:posts_clean_architecture/features/posts/domain/entities/post.dart';
import 'package:posts_clean_architecture/features/posts/domain/usecases/add_post.dart';
import 'package:posts_clean_architecture/features/posts/domain/usecases/delete_post.dart';
import 'package:posts_clean_architecture/features/posts/domain/usecases/update_post.dart';
import 'package:posts_clean_architecture/features/posts/presentation/blocs/posts/posts_bloc.dart';

part 'add_delete_update_posts_event.dart';
part 'add_delete_update_posts_state.dart';

class AddDeleteUpdatePostsBloc
    extends Bloc<AddDeleteUpdatePostsEvent, AddDeleteUpdatePostsState> {
  final AddPostUsecase addPost;
  final UpdatePostUsecase updatePost;
  final DeletePostUsecase deletePost;
  AddDeleteUpdatePostsBloc(
      {required this.addPost,
      required this.updatePost,
      required this.deletePost})
      : super(AddDeleteUpdatePostsInitial()) {
    on<AddDeleteUpdatePostsEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePostState());

        final failureOrDoneMessage = await addPost(event.post);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, addSuccessMessage),
        );
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());

        final failureOrDoneMessage = await updatePost(event.post);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, updateSuccessMessage),
        );
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());

        final failureOrDoneMessage = await deletePost(event.postId);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, deleteSuccessMessage),
        );
      }
    });
  }

  AddDeleteUpdatePostsState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAddDeleteUpdatePostState(
        message: _mapFailureToMessage(failure),
      ),
      (_) => MessageAddDeleteUpdatePostState(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case OfflineFailure:
        return offLineFailureMessage;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
