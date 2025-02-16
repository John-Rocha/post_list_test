import 'package:go_router/go_router.dart';
import 'package:post_list_test/features/presenter/pages/add_post_page.dart';
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
      // GoRoute(path: postDetail, builder: (context, state) => Container()),
    ],
  );
}
