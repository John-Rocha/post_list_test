import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:post_list_test/features/domain/entities/post_entity.dart';

class HiveService {
  static const String _postBoxName = 'posts';
  Future<Box<PostEntity>>? _postBoxFuture;

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(PostEntityAdapter());
    }
    _postBoxFuture = Hive.openBox<PostEntity>(_postBoxName);
  }

  Future<List<PostEntity>> getPosts() async {
    final box = await _postBoxFuture!;
    return box.values.toList();
  }

  Future<void> addPost(PostEntity post) async {
    final box = await _postBoxFuture!;
    await box.add(post);
  }

  Future<void> savePosts(List<PostEntity> newPosts) async {
    final box = await _postBoxFuture!;

    final existingPosts = box.values.toList();

    final mergedPosts = _mergePosts(existingPosts, newPosts);

    await box.addAll(mergedPosts);
  }

  Future<void> clearPosts() async {
    final box = await _postBoxFuture!;
    await box.clear();
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
