import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/src/common/error/failure.dart';
import 'package:flutter_clean_architecture/src/common/utils/typedef.dart';
import 'package:flutter_clean_architecture/src/core/extensions/dartz_extensions.dart';
import 'package:flutter_clean_architecture/src/feature/post/data/data_sources/local/post_local_data_source.dart';
import 'package:flutter_clean_architecture/src/feature/post/data/data_sources/remote/post_remote_data_source.dart';
import 'package:flutter_clean_architecture/src/feature/post/data/model/post_model.dart';
import 'package:flutter_clean_architecture/src/feature/post/data/repositories/post_repository_impl.dart';
import 'package:flutter_clean_architecture/src/feature/post/domain/repositories/post_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/post_data_source_mock.dart';

void main() {
  late PostRemoteDataSource remoteDataSource;
  late PostLocalDataSource localDataSource;
  late PostRepository postRepositoryImpl;

  setUp(() {
    remoteDataSource = MockPostRemoteDataSource();
    localDataSource = MockPostLocalDataSource();
    postRepositoryImpl = PostRepositoryImpl(remoteDataSource, localDataSource);
  });

  const tPostModel = PostModel(
    id: 1,
    title: '_test_title',
    body: '_test_body',
    userId: 1,
  );

  group('[PostRepositoryImpl] getAll', () {
    final tHttpResponse = ApiResponseWithoutModel<List<PostModel>>([tPostModel],
        Response(data: [tPostModel], statusCode: 200, requestOptions: RequestOptions(path: '')));

    test('should call [getAll] successfuly', () async {
      // arrange
      when(() => remoteDataSource.getPosts()).thenAnswer((_) async => tHttpResponse);
      // act
      await postRepositoryImpl.getAll();
      // assert
      verify(() => remoteDataSource.getPosts());
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('should return [List<PostModel>] when call [getAll] successful', () async {
      // arrange
      when(() => remoteDataSource.getPosts()).thenAnswer((_) async => tHttpResponse);
      // act
      final result = await postRepositoryImpl.getAll();
      // assert
      expect(result.right, [tPostModel]);
    });

    test('should return [ApiFailure] when call [getAll] failure', () async {
      final tError = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          statusMessage: 'Not Found',
          statusCode: 404,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      // arrange
      when(() => remoteDataSource.getPosts()).thenThrow(tError);
      // act
      final result = await postRepositoryImpl.getAll();
      // assert
      expect(result.left, isA<ApiFailure>());
    });

    test('should return [ServerFailure] when call [getAll]', () async {
      final tExpection = DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: ''),
          ));

      when(() => remoteDataSource.getPosts()).thenThrow(tExpection);
      final result = await postRepositoryImpl.getAll();
      expect(result.left, isA<ServerFailure>());
    });
  });

  group('[PostRepositoryImpl] getById', () {
    final tHttpResponse = ApiResponseWithoutModel<PostModel>(tPostModel,
        Response(data: tPostModel, statusCode: 200, requestOptions: RequestOptions(path: '')));

    test('should call [getById] successfuly', () async {
      // arrange
      when(() => remoteDataSource.getPostById(any())).thenAnswer((_) async => tHttpResponse);
      // act
      await postRepositoryImpl.getById(1);
      // assert
      verify(() => remoteDataSource.getPostById(1));
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('should return [PostModel] when call [getById] successful', () async {
      // arrange
      when(() => remoteDataSource.getPostById(any())).thenAnswer((_) async => tHttpResponse);
      // act
      final result = await postRepositoryImpl.getById(1);
      // assert
      expect(result.right, tPostModel);
    });

    test('should return [ApiFailure] when call [getById] failure', () async {
      final tError = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          statusMessage: 'Not Found',
          statusCode: 404,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      // arrange
      when(() => remoteDataSource.getPostById(any())).thenThrow(tError);
      // act
      final result = await postRepositoryImpl.getById(1);
      // assert
      expect(result.left, isA<ApiFailure>());
    });

    test('should return [ServerFailure] when call [getById]', () async {
      final tExpection = DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: ''),
          ));

      when(() => remoteDataSource.getPostById(any())).thenThrow(tExpection);
      final result = await postRepositoryImpl.getById(1);
      expect(result.left, isA<ServerFailure>());
    });
  });
}
