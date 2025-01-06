import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/src/core/usecases/usecase.dart';
import 'package:flutter_clean_architecture/src/features/splash/domain/entities/app_version.dart';
import 'package:flutter_clean_architecture/src/features/splash/domain/repositories/splash_repository.dart';
import 'package:flutter_clean_architecture/src/features/splash/domain/usecases/check_app_version.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSplashRepository extends Mock implements SplashRepository {}

void main() {
  late CheckAppVersion useCase;
  late MockSplashRepository mockRepository;

  setUp(() {
    mockRepository = MockSplashRepository();
    useCase = CheckAppVersion(mockRepository);
  });

  const testAppVersion = AppVersion(
    currentVersion: '1.0.0',
    minimumVersion: '1.0.0',
    forceUpdate: false,
  );

  test(
    'should get app version from the repository',
    () async {
      // arrange
      when(() => mockRepository.checkAppVersion())
          .thenAnswer((_) async => const Right(testAppVersion));

      // act
      final result = await useCase(NoParams());

      // assert
      expect(result, const Right(testAppVersion));
      verify(() => mockRepository.checkAppVersion()).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
