import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:post_list_test/features/data/datasource/post_datasource.dart';
import 'package:post_list_test/features/domain/entities/post_entity.dart';

typedef FetchPosts = Future<Either<Exception, List<PostEntity>>>;
typedef CreatePost = Future<Either<Exception, void>>;

abstract interface class PostRepository {
  FetchPosts fetchPosts();
  CreatePost createPost({required String title, required String body});
}

final class PostRepositoryImpl implements PostRepository {
  final PostDatasource _datasource;

  PostRepositoryImpl({required PostDatasource datasource})
    : _datasource = datasource;

  @override
  FetchPosts fetchPosts() async {
    try {
      final posts = await _datasource.fetchPosts();
      return Right(posts);
    } on DioException catch (e, s) {
      log('Erro ao buscar posts', error: e, stackTrace: s);
      return Left(Exception('Error fetching posts'));
    } catch (e, s) {
      log('Erro ao buscar posts', error: e, stackTrace: s);
      return Left(Exception('Erro ao buscar posts'));
    }
  }

  @override
  CreatePost createPost({required String title, required String body}) async {
    try {
      await _datasource.createPost(title: title, body: body);
      return Right(null);
    } on DioException catch (e, s) {
      log('Erro ao criar post', error: e, stackTrace: s);
      return Left(Exception('Erro ao criar post'));
    } catch (e, s) {
      log('Erro ao criar post', error: e, stackTrace: s);
      return Left(Exception('Erro ao criar post'));
    }
  }
}
