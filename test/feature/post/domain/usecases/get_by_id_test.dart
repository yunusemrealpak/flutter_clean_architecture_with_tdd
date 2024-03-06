import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/error/failure.dart';
import 'package:flutter_clean_architecture/core/extensions/dartz_extensions.dart';
import 'package:flutter_clean_architecture/feature/post/domain/entities/post_entity.dart';
import 'package:flutter_clean_architecture/feature/post/domain/repositories/post_repository.dart';
import 'package:flutter_clean_architecture/feature/post/domain/usecases/get_by_id.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/post_repository_mock.dart';

void main() {
  late GetById usecase;
  late PostRepository repository;

  setUp(() {
    repository = MockPostRepository();
    usecase = GetById(repository);
  });

  group('[GetById]', () {
    const tPost = PostEntity(id: 1, userId: 1, title: '_test_title', body: '_test_body');

    test('should call the repository succesfully', () async {
      //arrange
      when(() => repository.getById(any())).thenAnswer((_) async {
        return right(tPost);
      });
      //act
      await usecase(1);
      //asssert
      verify(() => repository.getById(1));
      verifyNoMoreInteractions(repository);
    });

    test('should return a [PostEntity] when call succesfully', () async {
      //arrange
      when(() => repository.getById(any())).thenAnswer((_) async {
        return right(tPost);
      });
      //act
      final result = await usecase(1);
      //assert
      expect(result.right, tPost);
    });

    test('should return [ApiFailure] when call failed, statusCode >=400 <500', () async {
      //arrange
      when(() => repository.getById(any())).thenAnswer((_) async {
        return left(const ApiFailure(statusCode: 400, message: 'error'));
      });
      //act
      final result = await usecase(1);
      //assert
      expect(result.left, isA<ApiFailure>());
      expect(result.left?.statusCode, equals(400));
      expect(result.left?.message, equals('error'));
    });

    test('should return [ServerFailure] when call failed, statusCode >=500', () async {
      //arrange
      when(() => repository.getById(any())).thenAnswer((_) async {
        return left(const ServerFailure(message: 'error', statusCode: 500));
      });
      //act
      final result = await usecase(1);
      //assert
      expect(result.left, isA<ServerFailure>());
      expect(result.left?.message, equals('error'));
      expect(result.left?.statusCode, equals(500));
    });
  });
}
