import 'package:go_router/go_router.dart';
import 'package:post_list_test/features/domain/entities/post_entity.dart';
import 'package:post_list_test/features/presenter/pages/add_post_page.dart';
import 'package:post_list_test/features/presenter/pages/post_details.dart';
import 'package:post_list_test/features/presenter/pages/posts_page.dart';

sealed class AppRoutes {
  static const String home = '/';
  static const String postForm = '/post-form';
  static const String postDetail = '/post-detail';

  static final routers = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: home,
    routes: [
      GoRoute(path: home, name: home, builder: (context, state) => PostsPage()),
      GoRoute(
        path: postForm,
        name: postForm,
        builder: (context, state) => AddPostPage(),
      ),
      GoRoute(
        path: postDetail,
        name: postDetail,
        builder:
            (context, state) => PostDetails(post: state.extra as PostEntity),
      ),
    ],
  );
}
