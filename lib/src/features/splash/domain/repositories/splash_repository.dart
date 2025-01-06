import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/app_version.dart';

abstract class SplashRepository {
  Future<Either<Failure, AppVersion>> checkAppVersion();
  Future<Either<Failure, bool>> checkUserToken();
}
