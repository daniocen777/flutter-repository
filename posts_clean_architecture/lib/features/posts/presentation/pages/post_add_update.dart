import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architecture/core/utils/snackbar_message.dart';
import 'package:posts_clean_architecture/core/widgets/loading_widget.dart';
import 'package:posts_clean_architecture/features/posts/domain/entities/post.dart';
import 'package:posts_clean_architecture/features/posts/presentation/blocs/add_delete_update_posts/add_delete_update_posts_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presentation/pages/posts_page.dart';
import 'package:posts_clean_architecture/features/posts/presentation/widgets/post_add_update_page/form_widget.dart';

/* BlocListener:
Este se utiliza para cuando queremos estar constantemente
escuchando todos los cambios que hay en los estados,
en este caso OrdersState. Cada vez que exista un cambio BlocListener
recibirá una notificación lo cual permita poder ejecutar una acción.
Cuando utilizamos BlocListener lo que dibujamos en pantalla
no depende del estado actual (OrdersState), sino que este es 
utilizado para conocer el estado actual y realizar una acción 
que no es dibujar un widget. Por ejemplo: Mandar un evento 
para analytics, hacer un API request, cambiar de pantalla, etc. */

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdate;

  const PostAddUpdatePage({super.key, this.post, required this.isUpdate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() =>
      AppBar(title: Text(isUpdate ? 'Edit ¨Post' : 'Add Post'));

/* BlocConsumer:
   Este una union entre BlocBuilder y BlocListener. 
   Este se utiliza cuando queremos dibujar algo con base 
   al estado (OrdersState) y por otra parte queremos tomar 
   acciones (e.g. Reportar Analytics) con base al estado. */
  Widget _buildBody(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: BlocConsumer<AddDeleteUpdatePostsBloc, AddDeleteUpdatePostsState>(
        listener: (context, state) {
          if (state is MessageAddDeleteUpdatePostState) {
            SnackBarMessage()
                .showSuccessSnackBar(message: state.message, context: context);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => const PostsPage()),
                (route) => false);
          } else if (state is ErrorAddDeleteUpdatePostState) {
            SnackBarMessage()
                .showErrorSnackBar(message: state.message, context: context);
          }
        },
        builder: (BuildContext context, state) {
          if (state is LoadingAddDeleteUpdatePostState) {
            return const LoadingWidget();
          }

          return FormWidget(
            isUpdatePost: isUpdate,
            post: post,
          );
        },
      ),
    ));
  }
}
