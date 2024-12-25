import 'package:dio/dio.dart';

import '../dio_config.dart';

class TokenInterceptor extends Interceptor {
  final DioClientConfig config;

  TokenInterceptor(this.config);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (config.enableTokenInterceptor && config.tokenProvider != null) {
      final token = await config.tokenProvider!.getToken();
      if (token != null && token.isNotEmpty) {
        // Authorization header'a ekleme
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    return handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    // Örneğin 401 döndüğünde login'e yönlendir
    if (err.response?.statusCode == 401) {
      if (config.onUnauthorized != null) {
        config.onUnauthorized!();
      }
    }
    return handler.next(err);
  }
}
