part of 'post_cubit.dart';

sealed class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

final class PostLoadingState extends PostState {
  const PostLoadingState();
}

final class PostErrorState extends PostState {
  final String message;

  const PostErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class PostLoadedState extends PostState {
  final List<PostEntity> posts;

  const PostLoadedState({required this.posts});

  @override
  List<Object> get props => [posts];
}
