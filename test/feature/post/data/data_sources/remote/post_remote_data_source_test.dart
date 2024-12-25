// import 'package:dio/dio.dart';
// import 'package:flutter_clean_architecture/src/common/utils/typedef.dart';
// import 'package:flutter_clean_architecture/src/feature/post/data/data_sources/remote/post_remote_data_source.dart';
// import 'package:flutter_clean_architecture/src/feature/post/data/model/post_model.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// 
// void main() {
//   late MockPostRestClient client;
//   late PostRemoteDataSource dataSource;
// 
//   setUp(() {
//     client = MockPostRestClient();
//     dataSource = PostRemoteDataSourceImpl(client);
//   });
// 
//   group('[PostRemoteDataSource] getPosts', () {
//     const tPostModel = PostModel(
//       id: 1,
//       title: '_test_title',
//       body: '_test_body',
//       userId: 1,
//     );
//     final tApiResponseModel = [tPostModel];
//     final tHttpResponseSuccess = ApiResponseWithoutModel(
//         tApiResponseModel,
//         Response(
//             data: tApiResponseModel, statusCode: 200, requestOptions: RequestOptions(path: '')));
//     final tHttpResponseFailure = ApiResponseWithoutModel(
//         null, Response(data: null, statusCode: 404, requestOptions: RequestOptions(path: '')));
// 
//     test('should call [getPosts] successfuly', () async {
//       // arrange
//       when(() => client.getPosts()).thenAnswer((_) async => tHttpResponseSuccess);
//       // act
//       await dataSource.getPosts();
//       // assert
//       verify(() => client.getPosts());
//       verifyNoMoreInteractions(client);
//     });
// 
//     test('should return a [List<PostModel>] when [client.getPosts] successfuly', () async {
//       // arrange
//       when(() => client.getPosts()).thenAnswer((_) async => tHttpResponseSuccess);
//       // act
//       final result = await dataSource.getPosts();
//       // assert
//       expect(result.data, isA<List<PostModel>>());
//     });
// 
//     test('should throw [DioException] when [client] throws [DioException]', () async {
//       // arrange
//       final tError = DioException(
//         requestOptions: RequestOptions(path: ''),
//         response: Response(
//           statusCode: 500,
//           requestOptions: RequestOptions(path: ''),
//         ),
//       );
// 
//       when(() => client.getPosts()).thenThrow(tError);
//       // act
//       final methodCall = dataSource.getPosts;
//       // assert
//       expect(() => methodCall(), throwsA(tError));
//     });
//   });
// }
