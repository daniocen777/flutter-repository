import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architecture/core/widgets/loading_widget.dart';
import 'package:posts_clean_architecture/features/posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presentation/pages/post_add_update.dart';
import 'package:posts_clean_architecture/features/posts/presentation/widgets/post_page/message_display_widget.dart';
import 'package:posts_clean_architecture/features/posts/presentation/widgets/post_page/posts_list_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _builBody(),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: const Text("Posts"),
      );

  /* BlocBuilder:
     Utilizado solo cuando se quiere dibujar un Widget dependiendo el State (estado) que recibamos
   */
  Widget _builBody() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (BuildContext context, state) {
          if (state is LoadingPostsState) {
            return const LoadingWidget();
          } else if (state is LoadedPostsState) {
            return RefreshIndicator(
                onRefresh: () => _onRefresh(context),
                child: PostListsWidget(posts: state.posts));
          } else if (state is ErrorPostsState) {
            return MessageDisplayWidget(message: state.message);
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const PostAddUpdatePage(isUpdate: false)));
      },
      child: const Icon(Icons.add),
    );
  }
}
