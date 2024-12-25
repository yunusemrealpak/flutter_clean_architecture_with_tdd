import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/src/common/usecases/usecase.dart';
import 'package:flutter_clean_architecture/src/common/utils/typedef.dart';
import 'package:flutter_clean_architecture/src/feature/post/domain/entities/post_entity.dart';
import 'package:flutter_clean_architecture/src/feature/post/domain/repositories/post_repository.dart';
import 'package:flutter_clean_architecture/src/infrastructure/core/extensions/dartz_extensions.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllPosts implements UseCaseWithoutParams<List<PostEntity>> {
  final PostRepository _repository;
  GetAllPosts(this._repository);

  @override
  EitherFuture<List<PostEntity>> call() async {
    final response = await _repository.getAll();

    if (response.isLeft()) {
      return left(response.left!);
    }

    await _repository.savePostsToLocal(response.right!);

    return right(response.right!);
  }
}
