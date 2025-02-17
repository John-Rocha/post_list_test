import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:post_list_test/features/domain/repositories/post_repository.dart';
import 'package:post_list_test/features/domain/entities/post_entity.dart';
import 'package:post_list_test/features/presenter/cubits/list_post/post_cubit.dart';
import 'package:post_list_test/features/presenter/cubits/add_post/add_post_cubit.dart';

class MockPostRepository extends Mock implements PostRepository {}

class MockPostCubit extends MockCubit<PostState> implements PostCubit {}

class FakePostEntity extends Fake implements PostEntity {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakePostEntity());
  });

  late MockPostRepository mockPostRepository;
  late MockPostCubit mockPostCubit;
  late AddPostCubit addPostCubit;

  setUp(() {
    mockPostRepository = MockPostRepository();
    mockPostCubit = MockPostCubit();
    addPostCubit = AddPostCubit(
      postRepository: mockPostRepository,
      postCubit: mockPostCubit,
    );
  });

  group('AddPostCubit', () {
    test('initial state should be AddPostState.empty()', () {
      expect(addPostCubit.state, equals(AddPostState.empty()));
    });

    blocTest<AddPostCubit, AddPostState>(
      'should emit [isSubmitting: true] then [empty] when addPost is successful',
      build: () {
        when(() => mockPostCubit.state).thenReturn(PostLoadedState(posts: []));
        when(
          () => mockPostCubit.addPostLocally(newPost: any(named: 'newPost')),
        ).thenReturn(null);
        when(
          () => mockPostRepository.createPost(
            title: any(named: 'title'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async =>
              Right(PostEntity(id: 1, title: 'New Post', body: 'New Body')),
        );
        return addPostCubit;
      },
      act: (cubit) => cubit.addPost(title: 'New Post', body: 'New Body'),
      expect:
          () => [
            isA<AddPostState>().having(
              (s) => s.isSubmitting,
              'isSubmitting',
              true,
            ),
            isA<AddPostState>()
                .having((s) => s.isSubmitting, 'isSubmitting', false)
                .having((s) => s.errorMessage, 'errorMessage', ''),
          ],
    );
  });
}
