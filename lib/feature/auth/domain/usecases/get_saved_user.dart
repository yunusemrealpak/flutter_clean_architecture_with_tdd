import 'package:flutter_clean_architecture/feature/auth/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/auth_repository.dart';

@injectable
final class GetSavedUser implements UseCaseWithoutParams<UserEntity> {
  final AuthRepository _authRepository;

  GetSavedUser(this._authRepository);

  @override
  EitherFuture<UserEntity> call() async {
    return await _authRepository.getSavedUser();
  }
}
