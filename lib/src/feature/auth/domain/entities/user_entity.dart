import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
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
