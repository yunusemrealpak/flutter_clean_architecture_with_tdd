import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/core/error/failure.dart';
import 'package:flutter_clean_architecture/core/network/response_error_handler.dart';
import 'package:flutter_clean_architecture/core/utils/typedef.dart';
import 'package:flutter_clean_architecture/feature/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:flutter_clean_architecture/feature/auth/data/models/user_model.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/entities/user_entity.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/params/sign_in_with_email_and_password_params.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  EitherFuture<UserEntity> signInWithEmailAndPassword(
      SignInWithEmailAndPasswordParams params) async {
    try {
      final response = await _authRemoteDataSource.signInWithEmailAndPassword(params);

      final responseModel = response.data.convertEntity<UserModel, UserModel>(const UserModel());

      if (responseModel.success == false || responseModel.entity == null) {
        return Left(DataFailure(message: responseModel.message ?? 'Bir hata oluştu'));
      }

      return Right(responseModel.entity as UserEntity);
    } on DioException catch (e) {
      return Left(ResponseErrorHandler.getFailure(e.response?.statusCode));
    }
  }

  @override
  EitherVoid signOut() async {
    await _authRemoteDataSource.signOut();
    return const Right(null);
  }

  @override
  EitherFuture<UserEntity> getSavedUser() {
    throw UnimplementedError();
  }
}
