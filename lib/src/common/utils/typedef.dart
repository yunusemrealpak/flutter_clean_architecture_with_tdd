import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/src/common/network/api_response_model.dart';
import 'package:retrofit/dio.dart';

import '../error/failure.dart';

typedef EitherFuture<T> = Future<Either<Failure, T>>;

typedef EitherVoid = EitherFuture<void>;

typedef DataMap = Map<String, dynamic>;

typedef DataList = List<Map<String, dynamic>>;

/// Network response model
typedef ApiResponse = HttpResponse<ApiResponseModel>;
typedef ApiResponseWithoutModel<T> = HttpResponse<T>;
