import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/src/infrastructure/di/injection_container.dart';
import 'package:injectable/injectable.dart';

import 'dio_client_config.dart';
import 'encryption/encryption_service.dart';
import 'error/error_handler.dart';
import 'error/network_error.dart';
import 'interceptors/cache_interceptor.dart';
import 'interceptors/encryption_interceptor.dart';
import 'interceptors/log_interceptor.dart';
import 'interceptors/token_interceptor.dart';

/// Tüm Interceptor'ları ve metodları yönetebileceğimiz ana client.
@injectable
class DioClient {
  late final Dio _dio;
  final DioClientConfig _config;

  DioClient(DioClientConfig config) : _config = config {
    _dio = Dio(BaseOptions(baseUrl: config.baseUrl));

    // Interceptor'ları ekle
    if (_config.enableTokenInterceptor && _config.tokenProvider != null) {
      _dio.interceptors.add(TokenInterceptor(_config));
    }
    if (_config.enableLogging) {
      _dio.interceptors.add(CustomLogInterceptor());
    }
    if (_config.enableCaching) {
      _dio.interceptors.add(di<CacheInterceptor>());
    }

    if (_config.enableEncryption &&
        _config.encryptionKeyBase64 != null &&
        _config.encryptionIVBase64 != null) {
      final encryptionService = EncryptionService(
        base64Key: _config.encryptionKeyBase64!,
        base64IV: _config.encryptionIVBase64!,
      );

      _dio.interceptors.add(
        EncryptionInterceptor(
          encryptionService: encryptionService,
          encryptRequestBody: true,
          decryptResponseBody: true,
          forceEncryptionOnServerResponse: _config.forceEncryptionOnServerResponse,
          skipEncryptionForPaths: _config.skipEncryptionForPaths,
        ),
      );
    }
  }

  /// -------------------------------------------------------------------------
  /// Generic parse metodu örneği:
  ///
  /// T fonksiyonu: model sınıfınız (ör. User, Product vs.)
  /// fromJson: Map<String, dynamic> alan ve T dönen fonksiyon
  ///
  /// Örnek kullanım:
  /// final user = await client.get<User>(
  ///   '/users/123',
  ///   fromJson: (json) => User.fromJson(json),
  /// );
  ///
  /// Bu şekilde model parse işlemini client katmanında soyutlayabilirsiniz.
  /// -------------------------------------------------------------------------
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return _parseResponse<T>(response, fromJson);
    } catch (error) {
      throw NetworkErrorHandler.handleError(error);
    }
  }

  Future<T> post<T>(
    String path, {
    dynamic data,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await _dio.post(path, data: data);
      return _parseResponse<T>(response, fromJson);
    } catch (error) {
      throw NetworkErrorHandler.handleError(error);
    }
  }

  Future<T> put<T>(
    String path, {
    dynamic data,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await _dio.put(path, data: data);
      return _parseResponse<T>(response, fromJson);
    } catch (error) {
      throw NetworkErrorHandler.handleError(error);
    }
  }

  Future<T> delete<T>(
    String path, {
    dynamic data,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await _dio.delete(path, data: data);
      return _parseResponse<T>(response, fromJson);
    } catch (error) {
      throw NetworkErrorHandler.handleError(error);
    }
  }

  /// Ortak parse fonksiyonu
  T _parseResponse<T>(Response response, T Function(Map<String, dynamic>)? fromJson) {
    try {
      if (fromJson == null) {
        return response.data as T;
      } else {
        if (response.data is! Map<String, dynamic>) {
          throw ServerError(
            message: 'Geçersiz yanıt formatı',
            statusCode: response.statusCode,
            error: response.data,
          );
        }
        return fromJson(response.data as Map<String, dynamic>);
      }
    } catch (error) {
      throw NetworkErrorHandler.handleError(error);
    }
  }
}
