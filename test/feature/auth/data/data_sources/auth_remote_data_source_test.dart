import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retrofit/dio.dart';
import 'package:flutter_clean_architecture/core/error/failure.dart';
import 'package:flutter_clean_architecture/core/network/api_response_model.dart';
import 'package:flutter_clean_architecture/feature/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:flutter_clean_architecture/feature/auth/data/models/user_model.dart';
import 'package:flutter_clean_architecture/feature/auth/domain/entities/params/sign_in_with_email_and_password_params.dart';

import '../../mock/mock_auth_rest_client.dart';

void main() {
  late MockAuthRestClient client;
  late AuthRemoteDataSource dataSource;

  setUp(() {
    client = MockAuthRestClient();
    dataSource = AuthRemoteDataSourceImpl(client);
  });

  group('[AuthRemoteDataSource] signInWithEmailAndPassword', () {
    const tSigninRequest = SignInWithEmailAndPasswordParams.test();

    ApiResponseModel tResponseModelSuccess = ApiResponseModel(
      success: true,
      message: 'Success',
      entity: const UserModel.test(),
    );

    ApiResponseModel tResponseModelFailure = ApiResponseModel(
      success: false,
      message: 'Bir sorun oluştu. Lütfen tekrar deneyin.',
      entity: null,
    );

    const tResponseUser = UserModel.test();
    final tResponseData = {'data': json.encode(tResponseUser.toJson())};

    test('should return a valid response', () async {
      // arrange
      when(() => client.signInWithEmailAndPassword(tSigninRequest)).thenAnswer(
        (_) async => HttpResponse(
            tResponseModelSuccess,
            Response(
                data: tResponseModelSuccess,
                statusCode: 200,
                requestOptions: RequestOptions(path: ''))),
      );

      // act
      final result = await dataSource.signInWithEmailAndPassword(tSigninRequest);

      // assert
      expect(result.data, isA<ApiResponseModel>());
      expect(result.data.entity, tResponseUser);
    });

    test('should return a [DataFailure] when the response code is 404 or other (unsuccess)',
        () async {
      // arrange
      when(() => client.signInWithEmailAndPassword(tSigninRequest)).thenAnswer(
        (_) async => HttpResponse(
            tResponseModelFailure,
            Response(
                data: DioException(
                  response: Response(
                    statusMessage: 'Something went wrong',
                    statusCode: 404,
                    requestOptions: RequestOptions(path: ''),
                  ),
                  requestOptions: RequestOptions(path: ''),
                ),
                statusCode: 404,
                requestOptions: RequestOptions(path: ''))),
      );

      // act
      final result = await dataSource.signInWithEmailAndPassword(tSigninRequest);

      final failure = result.data.dataFailure;

      // assert
      expect(failure, isA<DataFailure>());
      expect(failure.message, equals('Bir sorun oluştu. Lütfen tekrar deneyin.'));
    });

    test('should return a [ServerFailure] when the response code is 500', () async {
      // arrange
      final tError = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          statusMessage: 'Something went wrong',
          statusCode: 500,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      when(() => client.signInWithEmailAndPassword(tSigninRequest)).thenThrow(tError);

      // act
      final methodCall = dataSource.signInWithEmailAndPassword;

      // assert
      expect(() => methodCall(tSigninRequest), throwsA(tError));
    });
  });
}
