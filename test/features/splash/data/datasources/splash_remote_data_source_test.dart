import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/src/core/error/exceptions.dart';
import 'package:flutter_clean_architecture/src/features/splash/data/datasources/splash_remote_data_source.dart';
import 'package:flutter_clean_architecture/src/features/splash/data/models/app_version_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late SplashRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = SplashRemoteDataSourceImpl(client: mockDio);
  });

  group('checkAppVersion', () {
    const testAppVersionModel = AppVersionModel(
      currentVersion: '1.0.0',
      minimumVersion: '1.0.0',
      forceUpdate: false,
    );

    test(
      'should return AppVersionModel when the response code is 200',
      () async {
        // arrange
        when(() => mockDio.get('/version')).thenAnswer(
          (_) async => Response(
            data: {
              'currentVersion': '1.0.0',
              'minimumVersion': '1.0.0',
              'forceUpdate': false,
            },
            statusCode: 200,
            requestOptions: RequestOptions(),
          ),
        );

        // act
        final result = await dataSource.checkAppVersion();

        // assert
        expect(result, equals(testAppVersionModel));
      },
    );

    test(
      'should throw a ServerException when the response code is not 200',
      () async {
        // arrange
        when(() => mockDio.get('/version')).thenThrow(DioException(
          requestOptions: RequestOptions(),
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(),
          ),
        ));

        // act
        final call = dataSource.checkAppVersion;

        // assert
        expect(() => call(), throwsA(isA<ServerException>()));
      },
    );
  });
}
