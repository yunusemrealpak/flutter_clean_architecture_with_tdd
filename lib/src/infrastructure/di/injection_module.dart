import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/src/config/network/network_configuration.dart';
import 'package:flutter_clean_architecture/src/core/network/dio_client_config.dart';
import 'package:flutter_clean_architecture/src/core/network/token/token_provider.dart';
import 'package:flutter_clean_architecture/src/infrastructure/di/injection_container.dart';
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

  @injectable
  DioClientConfig get dioClientConfig {
    return DioClientConfig(
      baseUrl: NetworkConfiguration.baseUrl,
      tokenProvider: di<ITokenProvider>(),
      onUnauthorized: () {
        // TODO: Login ekranına yönlendir
      },
    );
  }
}
