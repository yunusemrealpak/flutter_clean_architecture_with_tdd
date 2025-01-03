import 'package:dio/dio.dart';

import 'network_error.dart';

class NetworkErrorHandler {
  static NetworkError handleError(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    }

    return ServerError(
      message: 'Beklenmeyen bir hata oluştu',
      error: error,
    );
  }

  static NetworkError _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutError(
          message: 'Bağlantı zaman aşımına uğradı',
          error: error,
        );

      case DioExceptionType.connectionError:
        return ConnectionError(
          message: 'İnternet bağlantınızı kontrol edin',
          error: error,
        );

      case DioExceptionType.badResponse:
        return _handleResponseError(error);

      default:
        return ServerError(
          message: error.message ?? 'Bir hata oluştu',
          statusCode: error.response?.statusCode,
          error: error,
        );
    }
  }

  static NetworkError _handleResponseError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    switch (statusCode) {
      case 401:
        return UnauthorizedError(
          message: 'Oturum süreniz doldu',
          error: error,
        );
      case 403:
        return ServerError(
          message: 'Bu işlem için yetkiniz bulunmuyor',
          statusCode: statusCode,
          error: error,
        );
      case 404:
        return ServerError(
          message: 'İstek yapılan kaynak bulunamadı',
          statusCode: statusCode,
          error: error,
        );
      case 500:
      case 502:
      case 503:
        return ServerError(
          message: 'Sunucu hatası',
          statusCode: statusCode,
          error: error,
        );
      default:
        return ServerError(
          message: data?['message'] ?? 'Bir hata oluştu',
          statusCode: statusCode,
          error: error,
        );
    }
  }
}
