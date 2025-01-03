import 'package:flutter_clean_architecture/src/feature/auth/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../../infrastructure/common/usecases/usecase.dart';
import '../../../../infrastructure/common/utils/typedef.dart';
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
