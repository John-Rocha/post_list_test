import 'package:post_list_test/features/domain/entities/post_entity.dart';

sealed class PostModel {
  static PostEntity fromMap(Map<String, dynamic> map) {
    return PostEntity(id: map['id'], title: map['title'], body: map['body']);
  }
}
