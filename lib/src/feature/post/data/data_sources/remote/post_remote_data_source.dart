import 'package:flutter_clean_architecture/src/core/network/dio_client.dart';
import 'package:injectable/injectable.dart';

abstract interface class PostRemoteDataSource {
  // Future<ApiResponseWithoutModel<List<PostModel>>> getPosts();
  // Future<ApiResponseWithoutModel<PostModel>> getPostById(int id);
  // Future<ApiResponseWithoutModel<PostModel>> createPost(PostModel post);
}

@LazySingleton(as: PostRemoteDataSource)
class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final DioClient _client;

  PostRemoteDataSourceImpl(this._client);

  // @override
  // Future<ApiResponseWithoutModel<List<PostModel>>> getPosts() async {
  //   return _client.getPosts();
  // }

  // @override
  // Future<ApiResponseWithoutModel<PostModel>> getPostById(int id) async {
  //   return _client.getPostById(id);
  // }

  // @override
  // Future<ApiResponseWithoutModel<PostModel>> createPost(PostModel post) async {
  //   return _client.createPost(post);
  // }
}
