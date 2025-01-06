import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final int? id;
  final String? email;
  final String? name;
  final String? photoUrl;
  final String? token;

  const UserModel({
    this.id,
    this.email,
    this.name,
    this.photoUrl,
    this.token,
  });

  const UserModel.test()
      : id = 1,
        email = '_test_email',
        name = '_test_name',
        photoUrl = '_test_photoUrl',
        token = '_test_token';

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    int? id,
    String? email,
    String? name,
    String? photoUrl,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      token: token ?? this.token,
    );
  }

  UserEntity toEntity() => UserEntity(
        id: id,
        email: email,
        name: name,
        photoUrl: photoUrl,
        token: token,
      );
}
