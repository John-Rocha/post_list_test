import 'package:flutter/material.dart';
import 'package:post_list_test/features/domain/entities/post_entity.dart';

class PostList extends StatelessWidget {
  const PostList({super.key, required this.posts});

  final List<PostEntity> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,

      itemBuilder: (context, index) {
        final post = posts[index];

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 2,
          child: ListTile(
            leading: Icon(Icons.article),
            title: Text(post.title),
            subtitle: Text(post.body),
          ),
        );
      },
    );
  }
}
