import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:post_list_test/features/domain/entities/post_entity.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  setUpAll(() async {
    final directory = await Directory.systemTemp.createTemp();
    Hive.init(directory.path);
    Hive.registerAdapter(PostEntityAdapter());
  });

  group('PostEntity', () {
    test('should support value equality', () {
      final post1 = const PostEntity(id: 1, title: 'Title 1', body: 'Body 1');
      final post2 = const PostEntity(id: 1, title: 'Title 1', body: 'Body 1');
      final post3 = const PostEntity(id: 2, title: 'Title 2', body: 'Body 2');

      expect(post1, equals(post2));
      expect(post1, isNot(equals(post3)));
    });

    test('should serialize and deserialize correctly with Hive', () async {
      var box = await Hive.openBox<PostEntity>('testBox');

      final post = const PostEntity(id: 1, title: 'Test', body: 'Post Content');

      await box.put('post1', post);
      final retrievedPost = box.get('post1');

      expect(retrievedPost, equals(post));

      await box.close();
    });
  });
}
