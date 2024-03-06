import 'package:flutter_clean_architecture/core/utils/typedef.dart';

import '../entities/params/sign_in_with_email_and_password_params.dart';
import '../entities/user_entity.dart';

abstract interface class AuthRepository {
  EitherFuture<UserEntity> signInWithEmailAndPassword(SignInWithEmailAndPasswordParams params);
  EitherVoid signOut();
  EitherFuture<UserEntity> getSavedUser();
}
