import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/src/core/error/failures.dart';
import 'package:flutter_clean_architecture/src/features/splash/domain/entities/app_version.dart';
import 'package:flutter_clean_architecture/src/features/splash/domain/usecases/check_app_version.dart';
import 'package:flutter_clean_architecture/src/features/splash/domain/usecases/check_user_token.dart';
import 'package:flutter_clean_architecture/src/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCheckAppVersion extends Mock implements CheckAppVersion {}

class MockCheckUserToken extends Mock implements CheckUserToken {}

void main() {
  late SplashBloc bloc;
  late MockCheckAppVersion mockCheckAppVersion;
  late MockCheckUserToken mockCheckUserToken;

  setUp(() {
    mockCheckAppVersion = MockCheckAppVersion();
    mockCheckUserToken = MockCheckUserToken();
    bloc = SplashBloc(
      checkAppVersion: mockCheckAppVersion,
      checkUserToken: mockCheckUserToken,
    );
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state should be SplashInitial', () {
    expect(bloc.state, equals(SplashInitial()));
  });

  group('CheckInitialSetup', () {
    const testAppVersion = AppVersion(
      currentVersion: '1.0.0',
      minimumVersion: '1.0.0',
      forceUpdate: false,
    );

    void arrangeCheckAppVersionSuccess() {
      when(() => mockCheckAppVersion(any())).thenAnswer((_) async => const Right(testAppVersion));
    }

    void arrangeCheckUserTokenSuccess(bool hasToken) {
      when(() => mockCheckUserToken(any())).thenAnswer((_) async => Right(hasToken));
    }

    test(
      'should emit [Loading, RequiresUpdate] when version check indicates update needed',
      () async {
        // arrange
        const outdatedVersion = AppVersion(
          currentVersion: '1.0.0',
          minimumVersion: '2.0.0',
          forceUpdate: true,
        );
        when(() => mockCheckAppVersion(any()))
            .thenAnswer((_) async => const Right(outdatedVersion));

        // assert later
        final expected = [
          SplashLoading(),
          const RequiresUpdate(forceUpdate: true),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(CheckInitialSetup());
      },
    );

    test(
      'should emit [Loading, NavigateToHome] when version is current and user has token',
      () async {
        // arrange
        arrangeCheckAppVersionSuccess();
        arrangeCheckUserTokenSuccess(true);

        // assert later
        final expected = [
          SplashLoading(),
          NavigateToHome(),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(CheckInitialSetup());
      },
    );

    test(
      'should emit [Loading, NavigateToAuth] when version is current but user has no token',
      () async {
        // arrange
        arrangeCheckAppVersionSuccess();
        arrangeCheckUserTokenSuccess(false);

        // assert later
        final expected = [
          SplashLoading(),
          NavigateToAuth(),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(CheckInitialSetup());
      },
    );

    test(
      'should emit [Loading, Error] when version check fails',
      () async {
        // arrange
        when(() => mockCheckAppVersion(any())).thenAnswer((_) async => Left(ServerFailure()));

        // assert later
        final expected = [
          SplashLoading(),
          const SplashError('Versiyon kontrolü başarısız oldu'),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(CheckInitialSetup());
      },
    );

    test(
      'should emit [Loading, Error] when token check fails',
      () async {
        // arrange
        arrangeCheckAppVersionSuccess();
        when(() => mockCheckUserToken(any())).thenAnswer((_) async => Left(CacheFailure()));

        // assert later
        final expected = [
          SplashLoading(),
          const SplashError('Token kontrolü başarısız oldu'),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(CheckInitialSetup());
      },
    );
  });
}
