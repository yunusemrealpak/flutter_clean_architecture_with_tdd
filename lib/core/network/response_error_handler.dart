import 'package:flutter_clean_architecture/core/error/failure.dart';

class ResponseErrorHandler {
  static String getErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad Request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not Found';
      case 500:
        return 'Internal Server Error';
      case 503:
        return 'Service Unavailable';
      default:
        return 'Something went wrong';
    }
  }

  static Failure getFailure(int? statusCode) {
    if (statusCode == null) {
      return const ServerFailure(message: 'Something went wrong', statusCode: 500);
    }

    final message = getErrorMessage(statusCode);

    switch (statusCode) {
      case 400:
        return ApiFailure(message: message, statusCode: statusCode);
      case 401:
        return ApiFailure(message: message, statusCode: statusCode);
      case 403:
        return ApiFailure(message: message, statusCode: statusCode);
      case 404:
        return ApiFailure(message: message, statusCode: statusCode);
      case 500:
        return ServerFailure(message: message, statusCode: statusCode);
      case 503:
        return ServerFailure(message: message, statusCode: statusCode);
      default:
        return ServerFailure(message: message, statusCode: statusCode);
    }
  }
}
