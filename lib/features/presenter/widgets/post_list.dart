import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:post_list_test/core/router/app_routes.dart';
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

        return InkWell(
          onTap: () {
            context.pushNamed(AppRoutes.postDetail, extra: post);
          },
          borderRadius: BorderRadius.circular(20),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.antiAlias,
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(child: Text(post.id.toString())),
              title: Text(post.title),
              subtitle: Text(post.body),
            ),
          ),
        );
      },
    );
  }
}
