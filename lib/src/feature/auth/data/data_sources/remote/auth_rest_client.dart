import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../common/network/api_response_model.dart';
import '../../../../../common/utils/typedef.dart';
import '../../../domain/entities/params/sign_in_with_email_and_password_params.dart';
import 'auth_remote_data_source.dart';

part 'auth_rest_client.g.dart';

@lazySingleton
@RestApi()
abstract class AuthRestClient implements AuthRemoteDataSource {
  @factoryMethod
  factory AuthRestClient(Dio dio, {String baseUrl}) = _AuthRestClient;

  @override
  @POST('/signInWithEmailAndPassword')
  Future<ApiResponse> signInWithEmailAndPassword(@Body() SignInWithEmailAndPasswordParams params);

  @override
  @POST('/signOut')
  Future<void> signOut();
}
