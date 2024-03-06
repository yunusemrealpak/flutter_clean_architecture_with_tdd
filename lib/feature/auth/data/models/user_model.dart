import 'package:flutter_clean_architecture/core/network/data_model.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity implements DataModel {
  const UserModel({
    super.id,
    super.email,
    super.name,
    super.photoUrl,
    super.token,
  });

  const UserModel.test()
      : super(
          id: 1,
          email: '_test_email',
          name: '_test_name',
          photoUrl: '_test_photoUrl',
          token: '_test_token',
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  UserModel fromJson(Map<String, dynamic> json) => UserModel.fromJson(json);

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
}
