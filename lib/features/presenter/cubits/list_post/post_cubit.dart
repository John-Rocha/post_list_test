import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_list_test/features/domain/entities/post_entity.dart';
import 'package:post_list_test/features/domain/repositories/post_repository.dart';
import 'package:post_list_test/core/services/hive_service.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepository _postRepository;
  final HiveService _hiveService;

  PostCubit({
    required PostRepository postRepository,
    required HiveService hiveService,
  }) : _postRepository = postRepository,
       _hiveService = hiveService,
       super(PostLoadingState()) {
    _init();
  }

  Future<void> _init() async {
    await _hiveService.init();
    await fetchPosts();
  }

  Future<void> fetchPosts() async {
    emit(PostLoadingState());

    final localPosts = await _hiveService.getPosts();

    final result = await _postRepository.fetchPosts();
    result.fold(
      (error) => emit(PostErrorState(message: 'Erro ao buscar posts')),
      (apiPosts) {
        final mergedPosts = _mergePosts(localPosts, apiPosts);

        _hiveService.savePosts(mergedPosts);

        emit(PostLoadedState(posts: mergedPosts.reversed.toList()));
      },
    );
  }

  void addPostLocally({required PostEntity newPost}) {
    if (state is PostLoadedState) {
      final currentState = state as PostLoadedState;

      final updatedPosts = List<PostEntity>.from(currentState.posts)
        ..insert(0, newPost);

      _hiveService.savePosts(updatedPosts);

      emit(PostLoadedState(posts: updatedPosts));
    }
  }

  List<PostEntity> _mergePosts(
    List<PostEntity> localPosts,
    List<PostEntity> apiPosts,
  ) {
    final mergedPosts = [...localPosts];

    for (final post in apiPosts) {
      if (!mergedPosts.any((p) => p.id == post.id)) {
        mergedPosts.add(post);
      }
    }

    return mergedPosts;
  }
}
