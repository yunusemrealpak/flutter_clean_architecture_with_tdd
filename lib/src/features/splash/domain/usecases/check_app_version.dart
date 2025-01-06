import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/app_version.dart';
import '../repositories/splash_repository.dart';

@lazySingleton
class CheckAppVersion implements UseCase<AppVersion, NoParams> {
  final SplashRepository repository;

  CheckAppVersion(this.repository);

  @override
  Future<Either<Failure, AppVersion>> call(NoParams params) async {
    return await repository.checkAppVersion();
  }
}
