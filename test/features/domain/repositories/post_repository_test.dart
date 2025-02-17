import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:post_list_test/features/data/datasource/post_datasource.dart';
import 'package:post_list_test/features/domain/entities/post_entity.dart';
import 'package:post_list_test/features/domain/repositories/post_repository.dart';

class MockPostDatasource extends Mock implements PostDatasource {}

void main() {
  late PostRepositoryImpl postRepository;
  late PostDatasource mockPostDatasource;

  setUp(() {
    mockPostDatasource = MockPostDatasource();
    postRepository = PostRepositoryImpl(datasource: mockPostDatasource);
  });

  group('PostRepository', () {
    test(
      'should return a list of posts when fetchPosts is successful',
      () async {
        final posts = [
          const PostEntity(id: 1, title: 'Title 1', body: 'Body 1'),
          const PostEntity(id: 2, title: 'Title 2', body: 'Body 2'),
        ];

        when(
          () => mockPostDatasource.fetchPosts(),
        ).thenAnswer((_) async => posts);

        final result = await postRepository.fetchPosts();

        expect(result, Right(posts));
        verify(() => mockPostDatasource.fetchPosts()).called(1);
        verifyNoMoreInteractions(mockPostDatasource);
      },
    );

    test('should return an exception when fetchPosts fails', () async {
      when(
        () => mockPostDatasource.fetchPosts(),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final result = await postRepository.fetchPosts();

      expect(result.isLeft(), true);
      verify(() => mockPostDatasource.fetchPosts()).called(1);
      verifyNoMoreInteractions(mockPostDatasource);
    });

    test(
      'should return a created post when createPost is successful',
      () async {
        final post = const PostEntity(
          id: 3,
          title: 'New Post',
          body: 'New Body',
        );

        when(
          () => mockPostDatasource.createPost(
            title: any(named: 'title'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => post);

        final result = await postRepository.createPost(
          title: 'New Post',
          body: 'New Body',
        );

        expect(result, Right(post));
        verify(
          () => mockPostDatasource.createPost(
            title: 'New Post',
            body: 'New Body',
          ),
        ).called(1);
        verifyNoMoreInteractions(mockPostDatasource);
      },
    );

    test('should return an exception when createPost fails', () async {
      when(
        () => mockPostDatasource.createPost(
          title: any(named: 'title'),
          body: any(named: 'body'),
        ),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final result = await postRepository.createPost(
        title: 'New Post',
        body: 'New Body',
      );

      expect(result.isLeft(), true);
      verify(
        () =>
            mockPostDatasource.createPost(title: 'New Post', body: 'New Body'),
      ).called(1);
      verifyNoMoreInteractions(mockPostDatasource);
    });
  });
}
