import 'package:flutter_clean_architecture/src/core/network/dio_client.dart';
import 'package:flutter_clean_architecture/src/features/auth/data/models/user_model.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/params/sign_in_with_email_and_password_params.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signInWithEmailAndPassword(SignInWithEmailAndPasswordParams params);
  Future<void> signOut();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _client;
  AuthRemoteDataSourceImpl(this._client);

  @override
  Future<UserModel> signInWithEmailAndPassword(SignInWithEmailAndPasswordParams params) async {
    return const UserModel();
  }

  @override
  Future<void> signOut() async {}
}
