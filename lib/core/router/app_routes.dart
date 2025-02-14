import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

sealed class AppRoutes {
  static const String home = '/';
  static const String postForm = '/post-form';
  static const String postDetail = '/post-detail';

  static final routers = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: home,
        builder:
            (context, state) => Scaffold(appBar: AppBar(title: Text('data'))),
      ),
    ],
  );
}
