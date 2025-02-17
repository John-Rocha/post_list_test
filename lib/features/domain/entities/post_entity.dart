import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'post_entity.g.dart';

@HiveType(typeId: 0)
class PostEntity extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String body;

  const PostEntity({required this.id, required this.title, required this.body});

  @override
  List<Object> get props => [id, title, body];
}
