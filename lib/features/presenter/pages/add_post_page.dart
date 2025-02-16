import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_list_test/core/di/inject.dart';
import 'package:post_list_test/core/validators/body.dart';
import 'package:post_list_test/core/validators/title.dart';
import 'package:post_list_test/features/presenter/cubits/add_post/add_post_cubit.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  late final AddPostCubit _addPostCubit;

  @override
  void initState() {
    super.initState();
    _addPostCubit = getIt<AddPostCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPostCubit, AddPostState>(
      bloc: _addPostCubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Criar Post')),
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Título',
                    errorText: switch (state.title.displayError) {
                      TitleValidationError.empty => 'Campo obrigatório',
                      _ => null,
                    },
                  ),
                  onChanged: (value) {
                    _addPostCubit.titleChanged(value);
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Corpo',
                    errorText: switch (state.body.displayError) {
                      BodyValidationError.empty => 'Campo obrigatório',
                      _ => null,
                    },
                  ),
                  onChanged: (value) {
                    _addPostCubit.bodyChanged(value);
                  },
                  maxLines: 5,
                ),
                Spacer(),
                ElevatedButton(
                  onPressed:
                      state.isValid
                          ? () {
                            _addPostCubit.addPost(
                              title: state.title.value,
                              body: state.body.value,
                            );

                            Navigator.of(context).pop(true);
                          }
                          : null,
                  child:
                      state.isSubmitting
                          ? CircularProgressIndicator()
                          : const Text('Criar'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
