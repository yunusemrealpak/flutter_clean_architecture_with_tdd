import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/src/feature/auth/domain/entities/params/sign_in_with_email_and_password_params.dart';
import 'package:flutter_clean_architecture/src/feature/auth/domain/entities/user_entity.dart';
import 'package:flutter_clean_architecture/src/feature/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_clean_architecture/src/feature/auth/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../auth_repository_mocks.dart';

void main() {
  late AuthRepository mockAuthRepository;
  late SignInWithEmailAndPassword usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = SignInWithEmailAndPassword(mockAuthRepository);
  });

  const tParams = SignInWithEmailAndPasswordParams.test();
  const tUserEntity = UserEntity(
    id: 1,
    email: '_test_email',
    name: '_test_name',
    photoUrl: '_test_photoUrl',
    token: '_test_token',
  );

  test('should sign in with email and password', () async {
    // arrange
    when(() => mockAuthRepository.signInWithEmailAndPassword(tParams))
        .thenAnswer((_) async => right(tUserEntity));

    // act
    final result = await usecase.call(tParams);

    // assert
    expect(result, right(tUserEntity));
    verify(() => mockAuthRepository.signInWithEmailAndPassword(tParams)).called(1);

    verifyNoMoreInteractions(mockAuthRepository);
  });
}
