import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:post_list_test/features/data/datasource/post_datasource.dart';
import 'package:post_list_test/features/domain/entities/post_entity.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late PostDatasourceImpl postDatasource;
  late Dio mockDio;

  setUp(() {
    mockDio = MockDio();
    postDatasource = PostDatasourceImpl(dio: mockDio);
  });

  group('PostDatasource', () {
    test(
      'should return a list of posts when fetchPosts is successful',
      () async {
        final mockResponse = [
          {'id': 1, 'title': 'Title 1', 'body': 'Body 1'},
          {'id': 2, 'title': 'Title 2', 'body': 'Body 2'},
        ];

        when(() => mockDio.get('/posts')).thenAnswer(
          (_) async => Response(
            data: mockResponse,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/posts'),
          ),
        );

        final result = await postDatasource.fetchPosts();

        expect(result, isA<List<PostEntity>>());
        expect(result.length, equals(2));
        expect(result.first.title, equals('Title 1'));
        verify(() => mockDio.get('/posts')).called(1);
      },
    );

    test('should throw a DioException when fetchPosts fails', () async {
      when(
        () => mockDio.get('/posts'),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: '/posts')));

      expect(() => postDatasource.fetchPosts(), throwsA(isA<DioException>()));
      verify(() => mockDio.get('/posts')).called(1);
    });

    test('should return a PostEntity when createPost is successful', () async {
      final mockResponse = {'id': 3, 'title': 'New Post', 'body': 'New Body'};

      when(() => mockDio.post('/posts', data: any(named: 'data'))).thenAnswer(
        (_) async => Response(
          data: mockResponse,
          statusCode: 201,
          requestOptions: RequestOptions(path: '/posts'),
        ),
      );

      final result = await postDatasource.createPost(
        title: 'New Post',
        body: 'New Body',
      );

      expect(result, isA<PostEntity>());
      expect(result.title, equals('New Post'));
      verify(
        () => mockDio.post(
          '/posts',
          data: {'title': 'New Post', 'body': 'New Body'},
        ),
      ).called(1);
    });

    test('should throw a DioException when createPost fails', () async {
      when(
        () => mockDio.post('/posts', data: any(named: 'data')),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: '/posts')));

      expect(
        () => postDatasource.createPost(title: 'New Post', body: 'New Body'),
        throwsA(isA<DioException>()),
      );
      verify(
        () => mockDio.post(
          '/posts',
          data: {'title': 'New Post', 'body': 'New Body'},
        ),
      ).called(1);
    });
  });
}
