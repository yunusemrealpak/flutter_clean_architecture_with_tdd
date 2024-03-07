import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/src/feature/auth/domain/entities/user_entity.dart';
import 'package:flutter_clean_architecture/src/feature/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_clean_architecture/src/feature/auth/domain/usecases/get_saved_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../auth_repository_mocks.dart';

void main() {
  late AuthRepository mockAuthRepository;
  late GetSavedUser usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = GetSavedUser(mockAuthRepository);
  });

  group('[GetSavedUser] call', () {
    const tUserEntity = UserEntity(
      id: 1,
      email: '_test_email',
      name: '_test_name',
      photoUrl: '_test_photoUrl',
      token: '_test_token',
    );

    test('should get saved user', () async {
      // arrange
      when(() => mockAuthRepository.getSavedUser()).thenAnswer((_) async => right(tUserEntity));

      // act
      final result = await usecase.call();

      // assert
      expect(result, right(tUserEntity));
      verify(() => mockAuthRepository.getSavedUser()).called(1);

      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}
