import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:post_list_test/core/cubit/theme/theme_cubit.dart';
import 'package:post_list_test/core/services/hive_service.dart';
import 'package:post_list_test/features/data/datasource/post_datasource.dart';
import 'package:post_list_test/features/domain/repositories/post_repository.dart';
import 'package:post_list_test/features/presenter/cubits/add_post/add_post_cubit.dart';
import 'package:post_list_test/features/presenter/cubits/list_post/post_cubit.dart';

final getIt = GetIt.instance;

void inject() {
  getIt.registerSingleton<Dio>(
    Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'))
      ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true)),
  );
  getIt.registerLazySingleton<PostDatasource>(
    () => PostDatasourceImpl(dio: getIt<Dio>()),
  );

  getIt.registerLazySingleton(() => HiveService()..init());

  getIt.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(datasource: getIt<PostDatasource>()),
  );

  getIt.registerSingleton<ThemeCubit>(ThemeCubit());

  getIt.registerSingleton<PostCubit>(
    PostCubit(
      postRepository: getIt<PostRepository>(),
      hiveService: getIt<HiveService>(),
    ),
  );

  getIt.registerSingleton<AddPostCubit>(
    AddPostCubit(
      postRepository: getIt<PostRepository>(),
      postCubit: getIt<PostCubit>(),
    ),
  );
}
