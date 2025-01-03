import 'package:flutter_clean_architecture/src/infrastructure/common/error/failure.dart';

abstract class NetworkError extends Failure implements Exception {
  final dynamic error;

  const NetworkError({
    required super.message,
    super.statusCode,
    this.error,
  });
}

class ServerError extends NetworkError {
  const ServerError({
    required super.message,
    super.statusCode,
    super.error,
  });
}

class ConnectionError extends NetworkError {
  const ConnectionError({
    required super.message,
    super.error,
  });
}

class TimeoutError extends NetworkError {
  const TimeoutError({
    required super.message,
    super.error,
  });
}

class UnauthorizedError extends NetworkError {
  const UnauthorizedError({
    required super.message,
    super.error,
  }) : super(
          statusCode: 401,
        );
}
