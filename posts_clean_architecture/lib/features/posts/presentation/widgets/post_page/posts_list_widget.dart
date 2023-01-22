import 'package:flutter/material.dart';

import 'package:posts_clean_architecture/features/posts/domain/entities/post.dart';
import 'package:posts_clean_architecture/features/posts/presentation/pages/post_detail_page.dart';

class PostListsWidget extends StatelessWidget {
  final List<Post> posts;

  const PostListsWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Text(posts[index].id.toString()),
          title: Text(posts[index].title,
              style:
                  const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
          subtitle:
              Text(posts[index].body, style: const TextStyle(fontSize: 12.0)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => PostDetailPage(post: posts[index]))),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(thickness: 1.0),
    );
  }
}
