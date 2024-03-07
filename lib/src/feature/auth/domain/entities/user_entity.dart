import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/src/common/repository/entity.dart';

class UserEntity extends Equatable implements Entity {
  final int? id;
  final String? email;
  final String? name;
  final String? photoUrl;
  final String? token;

  const UserEntity({
    this.id,
    this.email,
    this.name,
    this.photoUrl,
    this.token,
  });

  @override
  List<Object?> get props => [id, email, name, photoUrl, token];
}
