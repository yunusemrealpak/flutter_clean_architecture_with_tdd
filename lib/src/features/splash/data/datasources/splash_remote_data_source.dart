import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../models/app_version_model.dart';

abstract class SplashRemoteDataSource {
  Future<AppVersionModel> checkAppVersion();
}

@LazySingleton(as: SplashRemoteDataSource)
class SplashRemoteDataSourceImpl implements SplashRemoteDataSource {
  final Dio client;

  SplashRemoteDataSourceImpl({required this.client});

  @override
  Future<AppVersionModel> checkAppVersion() async {
    try {
      final response = await client.get('/version');
      return AppVersionModel.fromJson(response.data);
    } on DioException {
      throw ServerException();
    }
  }
}
