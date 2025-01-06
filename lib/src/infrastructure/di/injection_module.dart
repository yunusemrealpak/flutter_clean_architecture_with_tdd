import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/network/dio_client_config.dart';
import '../../core/network/token/token_provider.dart';
import '../config/network/network_configuration.dart';
import 'injection_container.dart';

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

  @lazySingleton
  InternetConnectionChecker get connectionChecker => InternetConnectionChecker();

  @preResolve
  Future<SharedPreferences> get sharedPreferences => SharedPreferences.getInstance();
}
