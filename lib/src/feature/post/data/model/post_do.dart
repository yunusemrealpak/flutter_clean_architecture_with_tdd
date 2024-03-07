import 'package:flutter_clean_architecture/src/common/local_database/db_object.dart';
import 'package:flutter_clean_architecture/src/feature/post/domain/entities/post_entity.dart';
import 'package:isar/isar.dart';

part 'post_do.g.dart';

@collection
class PostDO implements DBObject {
  Id? id;

  int? postId;
  int? userId;
  String? title;
  String? body;

  PostDO({
    this.id = Isar.autoIncrement,
    this.postId,
    this.userId,
    this.title,
    this.body,
  });

  PostDO.fromEntity(PostEntity entity)
      : postId = entity.id,
        userId = entity.userId,
        title = entity.title,
        body = entity.body;

  PostEntity toEntity() {
    return PostEntity(
      id: postId,
      userId: userId,
      title: title,
      body: body,
    );
  }

  PostDO copyWith({
    int? id,
    int? postId,
    int? userId,
    String? title,
    String? body,
  }) {
    return PostDO(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }
}
