import 'package:dio/dio.dart' hide Headers;
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/utils/typedef.dart';
import '../../model/post_model.dart';
import 'post_remote_data_source.dart';

part 'post_rest_client.g.dart';

@lazySingleton
@RestApi()
abstract class PostRestClient implements PostRemoteDataSource {
  @factoryMethod
  factory PostRestClient(Dio dio) = _PostRestClient;

  @override
  @GET('/posts')
  Future<ApiResponseWithoutModel<List<PostModel>>> getPosts();

  @override
  @GET('/posts/{id}')
  Future<ApiResponseWithoutModel<PostModel>> getPostById(@Path('id') int id);

  @override
  @POST('/posts')
  Future<ApiResponseWithoutModel<PostModel>> createPost(@Body() PostModel post);
}
