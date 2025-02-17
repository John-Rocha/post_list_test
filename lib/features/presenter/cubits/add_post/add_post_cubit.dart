import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:post_list_test/core/validators/body.dart';
import 'package:post_list_test/core/validators/title.dart';
import 'package:post_list_test/features/domain/entities/post_entity.dart';
import 'package:post_list_test/features/domain/repositories/post_repository.dart';
import 'package:post_list_test/features/presenter/cubits/list_post/post_cubit.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  final PostRepository _postRepository;
  final PostCubit _postCubit;
  AddPostCubit({
    required PostRepository postRepository,
    required PostCubit postCubit,
  }) : _postRepository = postRepository,
       _postCubit = postCubit,
       super(AddPostState.empty());

  Future<void> addPost({required String title, required String body}) async {
    emit(state.copyWith(isSubmitting: true));

    final currentState = _postCubit.state;

    int newId = 1;

    if (currentState is PostLoadedState && currentState.posts.isNotEmpty) {
      final maxId = currentState.posts
          .map((e) => e.id)
          .reduce((a, b) => a > b ? a : b);
      newId = maxId + 1;
    }

    final newLoacalPost = PostEntity(id: newId, title: title, body: body);

    _postCubit.addPostLocally(newPost: newLoacalPost);
    try {
      await _postRepository.createPost(title: title, body: body);
      emit(AddPostState.empty());
    } catch (e, s) {
      log('Error on addPost', error: e, stackTrace: s);
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: 'Erro ao adicionar post',
        ),
      );
    }
  }

  void titleChanged(String value) {
    final title = Title.dirty(value);
    emit(state.copyWith(title: title));
  }

  void bodyChanged(String value) {
    final body = Body.dirty(value);
    emit(state.copyWith(body: body));
  }
}
