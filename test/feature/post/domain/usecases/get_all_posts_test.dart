import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/error/failure.dart';
import 'package:flutter_clean_architecture/core/extensions/dartz_extensions.dart';
import 'package:flutter_clean_architecture/feature/post/domain/entities/post_entity.dart';
import 'package:flutter_clean_architecture/feature/post/domain/repositories/post_repository.dart';
import 'package:flutter_clean_architecture/feature/post/domain/usecases/get_all_posts.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/post_repository_mock.dart';

void main() {
  late PostRepository repository;
  late GetAllPosts usecase;

  setUp(() {
    repository = MockPostRepository();
    usecase = GetAllPosts(repository);
  });

  group('[GetAllPosts] call', () {
    const tPost = PostEntity(
      id: 1,
      userId: 1,
      title: '_test_title',
      body: '_test_body',
    );

    final tPostList = [tPost];

    test('should get all posts from the repository', () async {
      // arrange
      when(() => repository.getAll()).thenAnswer((_) async => right(tPostList));
      // act
      final result = await usecase.call();
      // assert
      expect(result.right, isA<List>());
      verify(() => repository.getAll());
      verifyNoMoreInteractions(repository);
    });

    test('should return a [List<Post>] of posts when success', () async {
      // arrange
      when(() => repository.getAll()).thenAnswer((_) async => right(tPostList));
      // act
      final result = await usecase.call();
      // assert
      expect(result.right, tPostList);
    });

    test('should return a [DataFailure] when failed', () async {
      // arrange
      when(() => repository.getAll())
          .thenAnswer((_) async => left(const DataFailure(message: 'Data Failure')));
      // act
      final result = await usecase.call();
      // assert
      expect(result.left, isA<DataFailure>());
      expect(result.left?.message, equals('Data Failure'));
    });

    test('should throw a [ServerFailure]', () async {
      // arrange
      when(() => repository.getAll()).thenAnswer(
          (_) async => left(const ServerFailure(message: 'Server Failure', statusCode: 500)));
      // act
      final result = await usecase.call();
      // assert
      expect(result.left, isA<ServerFailure>());
      expect(result.left?.statusCode, equals(500));
      expect(result.left?.message, equals('Server Failure'));
    });
  });
}
