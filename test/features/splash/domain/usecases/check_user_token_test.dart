import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/src/core/usecases/usecase.dart';
import 'package:flutter_clean_architecture/src/features/splash/domain/repositories/splash_repository.dart';
import 'package:flutter_clean_architecture/src/features/splash/domain/usecases/check_user_token.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSplashRepository extends Mock implements SplashRepository {}

void main() {
  late CheckUserToken useCase;
  late MockSplashRepository mockRepository;

  setUp(() {
    mockRepository = MockSplashRepository();
    useCase = CheckUserToken(mockRepository);
  });

  group('check user token', () {
    test(
      'should return true when user has token',
      () async {
        // arrange
        when(() => mockRepository.checkUserToken()).thenAnswer((_) async => const Right(true));

        // act
        final result = await useCase(NoParams());

        // assert
        expect(result, const Right(true));
        verify(() => mockRepository.checkUserToken()).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'should return false when user has no token',
      () async {
        // arrange
        when(() => mockRepository.checkUserToken()).thenAnswer((_) async => const Right(false));

        // act
        final result = await useCase(NoParams());

        // assert
        expect(result, const Right(false));
        verify(() => mockRepository.checkUserToken()).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );
  });
}
