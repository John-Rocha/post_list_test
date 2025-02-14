import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_list_test/core/cubit/theme/theme_cubit.dart';
import 'package:post_list_test/core/di/inject.dart';
import 'package:post_list_test/core/router/app_routes.dart';
import 'package:post_list_test/core/theme/app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeState) {
          return MaterialApp.router(
            title: 'Post List Test',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeState,
            routerConfig: AppRoutes.routers,
          );
        },
      ),
    );
  }
}
