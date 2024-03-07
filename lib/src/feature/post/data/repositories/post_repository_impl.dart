import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/src/common/network/response_error_handler.dart';
import 'package:flutter_clean_architecture/src/common/utils/typedef.dart';
import 'package:flutter_clean_architecture/src/feature/post/data/data_sources/remote/post_remote_data_source.dart';
import 'package:flutter_clean_architecture/src/feature/post/domain/entities/post_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/post_repository.dart';

@LazySingleton(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource _remoteDataSource;
  PostRepositoryImpl(this._remoteDataSource);

  @override
  Future<PostEntity> createPost(PostEntity post) async {
    throw UnimplementedError();
  }

  @override
  EitherFuture<List<PostEntity>> getAll() async {
    try {
      final response = await _remoteDataSource.getPosts();
      return right(response.data);
    } on DioException catch (e) {
      return left(ResponseErrorHandler.getFailure(e.response?.statusCode));
    }
  }

  @override
  EitherFuture<PostEntity> getById(int id) async {
    try {
      final response = await _remoteDataSource.getPostById(id);
      return right(response.data);
    } on DioException catch (e) {
      return left(ResponseErrorHandler.getFailure(e.response?.statusCode));
    }
  }
}
