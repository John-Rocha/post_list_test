import 'package:go_router/go_router.dart';
import 'package:post_list_test/features/presenter/pages/posts_page.dart';

sealed class AppRoutes {
  static const String home = '/';
  static const String postForm = '/post-form';
  static const String postDetail = '/post-detail';

  static final routers = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: home,
    routes: [GoRoute(path: home, builder: (context, state) => PostsPage())],
  );
}
