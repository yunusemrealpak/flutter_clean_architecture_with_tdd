import 'package:flutter_clean_architecture/src/core/error/exceptions.dart';
import 'package:flutter_clean_architecture/src/features/splash/data/datasources/splash_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SplashLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = SplashLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('checkUserToken', () {
    test(
      'should return true when there is a token in SharedPreferences',
      () async {
        // arrange
        when(() => mockSharedPreferences.getString(any())).thenReturn('some_token');

        // act
        final result = await dataSource.checkUserToken();

        // assert
        expect(result, true);
        verify(() => mockSharedPreferences.getString('USER_TOKEN')).called(1);
      },
    );

    test(
      'should return false when there is no token in SharedPreferences',
      () async {
        // arrange
        when(() => mockSharedPreferences.getString(any())).thenReturn(null);

        // act
        final result = await dataSource.checkUserToken();

        // assert
        expect(result, false);
        verify(() => mockSharedPreferences.getString('USER_TOKEN')).called(1);
      },
    );

    test(
      'should throw CacheException when SharedPreferences throws',
      () async {
        // arrange
        when(() => mockSharedPreferences.getString(any())).thenThrow(Exception());

        // act
        final call = dataSource.checkUserToken;

        // assert
        expect(() => call(), throwsA(isA<CacheException>()));
      },
    );
  });

  group('cacheUserToken', () {
    test(
      'should call SharedPreferences to cache the token',
      () async {
        // arrange
        when(() => mockSharedPreferences.setString(any(), any())).thenAnswer((_) async => true);
        const token = 'test_token';

        // act
        await dataSource.cacheUserToken(token);

        // assert
        verify(() => mockSharedPreferences.setString('USER_TOKEN', token)).called(1);
      },
    );

    test(
      'should throw CacheException when SharedPreferences throws',
      () async {
        // arrange
        when(() => mockSharedPreferences.setString(any(), any())).thenThrow(Exception());

        // act
        final call = dataSource.cacheUserToken;

        // assert
        expect(() => call('test_token'), throwsA(isA<CacheException>()));
      },
    );
  });
}
