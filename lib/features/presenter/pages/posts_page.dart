import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_list_test/core/cubit/theme/theme_cubit.dart';
import 'package:post_list_test/core/di/inject.dart';
import 'package:post_list_test/features/presenter/cubits/post_cubit.dart';
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
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed('/create-post');
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _postCubit.fetchPosts,

        child: Padding(
          padding: const EdgeInsets.all(12),
          child: BlocBuilder<PostCubit, PostState>(
            bloc: _postCubit,
            builder: (context, postState) {
              return switch (postState) {
                PostLoadingState() => Center(
                  child: CircularProgressIndicator(),
                ),

                PostErrorState(:final message) => Center(child: Text(message)),

                PostLoadedState(:final posts) => PostList(posts: posts),
              };
            },
          ),
        ),
      ),
    );
  }
}
