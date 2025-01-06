import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/splash_repository.dart';

@lazySingleton
class CheckUserToken implements UseCase<bool, NoParams> {
  final SplashRepository repository;

  CheckUserToken(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.checkUserToken();
  }
}
