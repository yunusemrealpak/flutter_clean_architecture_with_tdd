import 'package:flutter_clean_architecture/src/common/utils/typedef.dart';
import 'package:flutter_clean_architecture/src/feature/auth/data/data_sources/remote/auth_rest_client.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../domain/entities/params/sign_in_with_email_and_password_params.dart';

abstract interface class AuthRemoteDataSource {
  Future<ApiResponse> signInWithEmailAndPassword(SignInWithEmailAndPasswordParams params);
  Future<void> signOut();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthRestClient _client;
  AuthRemoteDataSourceImpl(this._client);

  @override
  Future<ApiResponse> signInWithEmailAndPassword(
      @Body() SignInWithEmailAndPasswordParams params) async {
    return _client.signInWithEmailAndPassword(params);
  }

  @override
  Future<void> signOut() async {
    return _client.signOut();
  }
}
