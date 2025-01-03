abstract class Failure {
  final int? statusCode;
  final String message;

  const Failure({required this.message, this.statusCode});
}

final class ApiFailure extends Failure {
  const ApiFailure({required super.message, required super.statusCode});
}

final class ServerFailure extends Failure {
  const ServerFailure({required super.message, required super.statusCode});
}

final class DataFailure extends Failure {
  const DataFailure({required super.message});
}

// final class CacheFailure extends Failure {
//   const CacheFailure({required super.message});
// }
