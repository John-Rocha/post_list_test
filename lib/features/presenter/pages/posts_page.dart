import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:post_list_test/core/cubit/theme/theme_cubit.dart';
import 'package:post_list_test/core/di/inject.dart';
import 'package:post_list_test/core/router/app_routes.dart';
import 'package:post_list_test/features/presenter/cubits/list_post/post_cubit.dart';
import 'package:post_list_test/features/presenter/widgets/post_list.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late final PostCubit _postCubit;

  @override
  void initState() {
    super.initState();

    _postCubit = getIt<PostCubit>()..fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              context.watch<ThemeCubit>().state == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
              color: Colors.amberAccent,
            ),
            onPressed: context.read<ThemeCubit>().toggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _postCubit.fetchPosts,
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocBuilder<PostCubit, PostState>(
          bloc: _postCubit,
          builder: (context, postState) {
            return switch (postState) {
              PostLoadingState() => Center(child: CircularProgressIndicator()),

              PostErrorState(:final message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 12,
                  children: [
                    Text(message, style: TextStyle(fontSize: 18)),
                    ElevatedButton(
                      onPressed: () => _postCubit.fetchPosts(),
                      child: const Text('Tentar novamente'),
                    ),
                  ],
                ),
              ),

              PostLoadedState(:final posts) => PostList(posts: posts),
            };
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await context.pushNamed<bool>(AppRoutes.postForm);

          if (result == true) {
            _postCubit.fetchPosts();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
