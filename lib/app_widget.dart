import 'package:flutter/material.dart';
import 'package:post_list_test/core/router/app_routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Post List Test',
      routerConfig: AppRoutes.routers,
    );
  }
}
