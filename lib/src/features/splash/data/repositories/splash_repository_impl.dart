import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/app_version.dart';
import '../../domain/repositories/splash_repository.dart';
import '../datasources/splash_local_data_source.dart';
import '../datasources/splash_remote_data_source.dart';

@LazySingleton(as: SplashRepository)
class SplashRepositoryImpl implements SplashRepository {
  final SplashRemoteDataSource remoteDataSource;
  final SplashLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SplashRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AppVersion>> checkAppVersion() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteVersion = await remoteDataSource.checkAppVersion();
        return Right(remoteVersion);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> checkUserToken() async {
    try {
      final hasToken = await localDataSource.checkUserToken();
      return Right(hasToken);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
