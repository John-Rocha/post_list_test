import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_list_test/features/domain/entities/post_entity.dart';
import 'package:post_list_test/features/domain/repositories/post_repository.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepository _postRepository;

  PostCubit({required PostRepository postRepository})
    : _postRepository = postRepository,
      super(PostLoadingState());

  Future<void> fetchPosts() async {
    emit(PostLoadingState());
    final result = await _postRepository.fetchPosts();
    result.fold(
      (error) => emit(PostErrorState(message: 'Erro ao buscar posts')),
      (posts) => emit(PostLoadedState(posts: posts.reversed.toList())),
    );
  }

  void addPostLocally({required PostEntity newPost}) {
    if (state is PostLoadedState) {
      final currentState = state as PostLoadedState;
      final updatedPosts = List<PostEntity>.from(currentState.posts)
        ..insert(0, newPost);
      emit(PostLoadedState(posts: updatedPosts));
    }
  }
}
