import 'package:flutter_clean_architecture/core/error/failure.dart';
import 'package:flutter_clean_architecture/core/network/data_model.dart';

final class ApiResponseModel {
  final bool success;
  final String? message;
  final dynamic entity;

  ApiResponseModel({
    this.success = true,
    this.entity,
    this.message,
  });

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) {
    return ApiResponseModel(
      success: json['success'] as bool,
      entity: json['entity'] as dynamic,
      message: json['message'] as String,
    );
  }

  ApiResponseModel convertEntity<T extends DataModel, R>(T model) {
    dynamic newEntity = entity;

    if (entity is List) {
      newEntity = (entity as List).map((data) => model.fromJson(data)).cast<T>().toList() as R;
    }

    if (entity is Map<String, dynamic>) {
      newEntity = model.fromJson(entity) as R;
    }

    return ApiResponseModel(
      success: success,
      entity: newEntity,
      message: message,
    );
  }

  @override
  String toString() =>
      'ApiResponseModel(successResponse: $success, data: $entity, message: $message)';

  DataFailure get dataFailure {
    return DataFailure(message: message ?? 'Bir hata oluştu');
  }
}
