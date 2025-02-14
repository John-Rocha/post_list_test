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
    final result = await _postRepository.fetchPosts();
    result.fold(
      (error) => emit(PostErrorState(message: 'Erro ao buscar posts')),
      (posts) => emit(PostLoadedState(posts: posts)),
    );
  }

  Future<void> createPost({required String title, required String body}) async {
    final result = await _postRepository.createPost(title: title, body: body);
    result.fold(
      (error) => emit(PostErrorState(message: 'Erro ao criar post')),
      (_) => fetchPosts(),
    );
  }
}
