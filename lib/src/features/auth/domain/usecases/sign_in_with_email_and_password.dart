import 'package:flutter_clean_architecture/src/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_clean_architecture/src/infrastructure/common/usecases/usecase.dart';
import 'package:flutter_clean_architecture/src/infrastructure/common/utils/typedef.dart';

import '../entities/params/sign_in_with_email_and_password_params.dart';
import '../repositories/auth_repository.dart';

final class SignInWithEmailAndPassword
    implements UseCase<UserEntity, SignInWithEmailAndPasswordParams> {
  final AuthRepository repository;

  SignInWithEmailAndPassword(this.repository);

  @override
  EitherFuture<UserEntity> call(SignInWithEmailAndPasswordParams params) async {
    return await repository.signInWithEmailAndPassword(params);
  }
}
