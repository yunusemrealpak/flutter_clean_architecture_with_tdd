import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/src/common/network/response_error_handler.dart';
import 'package:flutter_clean_architecture/src/common/utils/typedef.dart';
import 'package:flutter_clean_architecture/src/feature/post/data/data_sources/local/post_local_data_source.dart';
import 'package:flutter_clean_architecture/src/feature/post/data/data_sources/remote/post_remote_data_source.dart';
import 'package:flutter_clean_architecture/src/feature/post/data/model/post_do.dart';
import 'package:flutter_clean_architecture/src/feature/post/domain/entities/post_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/post_repository.dart';

@LazySingleton(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  final PostLocalDataSource _localDataSource;
  final PostRemoteDataSource _remoteDataSource;
  PostRepositoryImpl(this._remoteDataSource, this._localDataSource);

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

  @override
  Future<void> savePostsToLocal(List<PostEntity> posts) async {
    final list = posts.map((e) => PostDO.fromEntity(e)).toList();
    await _localDataSource.insertOrUpdateList(list);
  }

  @override
  Future<List<PostEntity>> getSavedAllPosts() async {
    final savedPosts = await _localDataSource.getAll();
    return savedPosts.map((e) {
      return e.toEntity();
    }).toList();
  }
}
