import 'package:flutter_clean_architecture/core/network/data_model.dart';
import 'package:flutter_clean_architecture/feature/post/domain/entities/post_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel extends PostEntity implements DataModel {
  const PostModel({
    super.id,
    super.userId,
    super.title,
    super.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  @override
  PostModel fromJson(Map<String, dynamic> json) => PostModel.fromJson(json);

  PostModel copyWith({
    int? id,
    int? userId,
    String? title,
    String? body,
  }) {
    return PostModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }
}
