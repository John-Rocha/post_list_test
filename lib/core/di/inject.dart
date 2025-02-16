import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:post_list_test/core/cubit/theme/theme_cubit.dart';
import 'package:post_list_test/features/data/datasource/post_datasource.dart';
import 'package:post_list_test/features/domain/repositories/post_repository.dart';
import 'package:post_list_test/features/presenter/cubits/list_post/post_cubit.dart';

final getIt = GetIt.instance;

void inject() {
  getIt.registerSingleton<Dio>(
    Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'))
      ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true)),
  );
  getIt.registerSingleton<PostDatasource>(
    PostDatasourceImpl(dio: getIt<Dio>()),
  );

  getIt.registerSingleton<PostRepository>(
    PostRepositoryImpl(datasource: getIt<PostDatasource>()),
  );

  getIt.registerSingleton<ThemeCubit>(ThemeCubit());

  getIt.registerSingleton<PostCubit>(
    PostCubit(postRepository: getIt<PostRepository>()),
  );
}
