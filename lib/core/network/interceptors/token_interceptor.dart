import 'package:dio/dio.dart';

import '../../../feature/auth/domain/repositories/auth_repository.dart';

final class TokenInterceptor extends Interceptor {
  final AuthRepository _authRepository;

  TokenInterceptor(this._authRepository);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // final token = _authRepository.getToken();
    // if (token != null) {
    //   options.headers['Authorization'] = 'Bearer $token';
    // }
    super.onRequest(options, handler);
  }
}
