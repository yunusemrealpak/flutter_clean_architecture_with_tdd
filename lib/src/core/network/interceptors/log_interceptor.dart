import 'package:dio/dio.dart';

/// Not: Dio'nun kendi LogInterceptor'ı var. Burada isteğe göre özelleştirilmiş
/// bir tanım gösteriyoruz. Proje ihtiyacınıza göre Dio'nun built-in
/// LogInterceptor'ını da kullanabilirsiniz.
class CustomLogInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQUEST] => ${options.method} ${options.uri}');
    print('[REQUEST HEADERS] => ${options.headers}');
    print('[REQUEST DATA] => ${options.data}');
    return handler.next(options);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    print('[RESPONSE] => ${response.statusCode} ${response.requestOptions.uri}');
    print('[RESPONSE DATA] => ${response.data}');
    return handler.next(response);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    print('[ERROR] => ${err.message}');
    return handler.next(err);
  }
}
