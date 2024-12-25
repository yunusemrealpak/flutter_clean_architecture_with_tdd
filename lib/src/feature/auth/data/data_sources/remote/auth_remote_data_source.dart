import 'package:flutter_clean_architecture/src/core/network/dio_client.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/params/sign_in_with_email_and_password_params.dart';

abstract interface class AuthRemoteDataSource {
  Future<void> signInWithEmailAndPassword(SignInWithEmailAndPasswordParams params);
  Future<void> signOut();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _client;
  AuthRemoteDataSourceImpl(this._client);

  @override
  Future<void> signInWithEmailAndPassword(SignInWithEmailAndPasswordParams params) async {}

  @override
  Future<void> signOut() async {}
}
