import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/src/common/repository/entity.dart';

class PostEntity extends Equatable implements Entity {
  final int? id;
  final int? userId;
  final String? title;
  final String? body;

  const PostEntity({
    this.id,
    this.userId,
    this.title,
    this.body,
  });

  @override
  List<Object?> get props => [id, title, body];
}
