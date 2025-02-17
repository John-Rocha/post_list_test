import 'package:flutter_test/flutter_test.dart';
import 'package:post_list_test/features/domain/entities/post_entity.dart';
import 'package:post_list_test/features/data/models/post_model.dart';

void main() {
  group('PostModel', () {
    test('should correctly convert a Map to a PostEntity', () {
      final map = {'id': 1, 'title': 'Test Title', 'body': 'Test Body'};

      final post = PostModel.fromMap(map);

      expect(post, isA<PostEntity>());
      expect(post.id, equals(1));
      expect(post.title, equals('Test Title'));
      expect(post.body, equals('Test Body'));
    });

    test('should throw an error if required fields are missing', () {
      final map = {'id': 1, 'title': 'Test Title'};

      expect(() => PostModel.fromMap(map), throwsA(isA<TypeError>()));
    });

    test('should throw an error if types do not match', () {
      final map = {
        'id': 'invalid_id',
        'title': 'Test Title',
        'body': 'Test Body',
      };

      expect(() => PostModel.fromMap(map), throwsA(isA<TypeError>()));
    });
  });
}
