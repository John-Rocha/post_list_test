import 'package:dio/dio.dart';
import 'package:post_list_test/features/data/models/post_model.dart';
import 'package:post_list_test/features/domain/entities/post_entity.dart';

abstract interface class PostDatasource {
  Future<List<PostEntity>> fetchPosts();
  Future<PostEntity> createPost({required String title, required String body});
}

final class PostDatasourceImpl implements PostDatasource {
  final Dio _dio;

  PostDatasourceImpl({required Dio dio}) : _dio = dio;
  @override
  Future<List<PostEntity>> fetchPosts() async {
    final Response(:data) = await _dio.get('/posts');

    final List<PostEntity> posts =
        (data as List).map((post) => PostModel.fromMap(post)).toList();

    return posts;
  }

  @override
  Future<PostEntity> createPost({
    required String title,
    required String body,
  }) async {
    final result = await _dio.post(
      '/posts',
      data: {'title': title, 'body': body},
    );

    return PostModel.fromMap(result.data);
  }
}
