part of 'add_post_cubit.dart';

class AddPostState extends Equatable {
  final Title title;
  final Body body;
  final bool isSubmitting;
  final String errorMessage;

  const AddPostState({
    required this.title,
    required this.body,
    required this.isSubmitting,
    required this.errorMessage,
  });

  const AddPostState.empty()
    : title = const Title.pure(),
      body = const Body.pure(),
      isSubmitting = false,
      errorMessage = '';

  bool get isValid => Formz.validate([title, body]);

  AddPostState copyWith({
    Title? title,
    Body? body,
    bool? isSubmitting,
    String? errorMessage,
  }) {
    return AddPostState(
      title: title ?? this.title,
      body: body ?? this.body,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [title, body, isSubmitting, errorMessage];
}
