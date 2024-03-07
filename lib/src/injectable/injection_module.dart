import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/src/config/network/network_configuration.dart';
import 'package:injectable/injectable.dart';

@module
abstract class InjectionModule {
  @lazySingleton
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: NetworkConfiguration.baseUrl,
        connectTimeout: NetworkConfiguration.connectTimeout,
        receiveTimeout: NetworkConfiguration.receiveTimeout,
        validateStatus: (status) =>
            status != null && status < NetworkConfiguration.validationStatusCode,
      ),
    );

    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));

    return dio;
  }
}
