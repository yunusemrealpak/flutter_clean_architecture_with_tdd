import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/core/constants/network_constants.dart';
import 'package:injectable/injectable.dart';

@module
abstract class InjectionModule {
  @lazySingleton
  Dio get dio => Dio(
        BaseOptions(
          baseUrl: NetworkConstants.baseUrl,
          connectTimeout: NetworkConstants.connectTimeout,
          receiveTimeout: NetworkConstants.receiveTimeout,
          validateStatus: (status) =>
              status != null && status < NetworkConstants.validationStatusCode,
        ),
      );
}
