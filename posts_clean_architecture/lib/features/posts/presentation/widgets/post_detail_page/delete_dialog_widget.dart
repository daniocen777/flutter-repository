import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:posts_clean_architecture/features/posts/presentation/blocs/add_delete_update_posts/add_delete_update_posts_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {
  final int postId;
  const DeleteDialogWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Are you Sure ?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("No"),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<AddDeleteUpdatePostsBloc>(context).add(
              DeletePostEvent(postId: postId),
            );
          },
          child: const Text("Yes"),
        ),
      ],
    );
  }
}
