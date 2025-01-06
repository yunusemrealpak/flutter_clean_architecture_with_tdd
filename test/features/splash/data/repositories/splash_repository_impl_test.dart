import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/src/core/error/exceptions.dart';
import 'package:flutter_clean_architecture/src/core/error/failures.dart';
import 'package:flutter_clean_architecture/src/core/network/network_info.dart';
import 'package:flutter_clean_architecture/src/features/splash/data/datasources/splash_local_data_source.dart';
import 'package:flutter_clean_architecture/src/features/splash/data/datasources/splash_remote_data_source.dart';
import 'package:flutter_clean_architecture/src/features/splash/data/models/app_version_model.dart';
import 'package:flutter_clean_architecture/src/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements SplashRemoteDataSource {}

class MockLocalDataSource extends Mock implements SplashLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late SplashRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = SplashRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('checkAppVersion', () {
    const testAppVersionModel = AppVersionModel(
      currentVersion: '1.0.0',
      minimumVersion: '1.0.0',
      forceUpdate: false,
    );

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.checkAppVersion())
            .thenAnswer((_) async => testAppVersionModel);

        // act
        await repository.checkAppVersion();

        // assert
        verify(() => mockNetworkInfo.isConnected).called(1);
      },
    );

    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.checkAppVersion())
              .thenAnswer((_) async => testAppVersionModel);

          // act
          final result = await repository.checkAppVersion();

          // assert
          verify(() => mockRemoteDataSource.checkAppVersion()).called(1);
          expect(result, equals(const Right(testAppVersionModel)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.checkAppVersion()).thenThrow(ServerException());

          // act
          final result = await repository.checkAppVersion();

          // assert
          verify(() => mockRemoteDataSource.checkAppVersion()).called(1);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'should return NetworkFailure when device is offline',
        () async {
          // act
          final result = await repository.checkAppVersion();

          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          expect(result, equals(Left(NetworkFailure())));
        },
      );
    });
  });

  group('checkUserToken', () {
    test(
      'should return true when token exists in local storage',
      () async {
        // arrange
        when(() => mockLocalDataSource.checkUserToken()).thenAnswer((_) async => true);

        // act
        final result = await repository.checkUserToken();

        // assert
        verify(() => mockLocalDataSource.checkUserToken()).called(1);
        expect(result, equals(const Right(true)));
      },
    );

    test(
      'should return false when token does not exist in local storage',
      () async {
        // arrange
        when(() => mockLocalDataSource.checkUserToken()).thenAnswer((_) async => false);

        // act
        final result = await repository.checkUserToken();

        // assert
        verify(() => mockLocalDataSource.checkUserToken()).called(1);
        expect(result, equals(const Right(false)));
      },
    );

    test(
      'should return CacheFailure when local storage throws',
      () async {
        // arrange
        when(() => mockLocalDataSource.checkUserToken()).thenThrow(CacheException());

        // act
        final result = await repository.checkUserToken();

        // assert
        verify(() => mockLocalDataSource.checkUserToken()).called(1);
        expect(result, equals(Left(CacheFailure())));
      },
    );
  });
}
