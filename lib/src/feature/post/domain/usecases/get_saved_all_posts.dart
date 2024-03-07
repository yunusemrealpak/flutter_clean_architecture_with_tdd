import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/src/feature/post/domain/entities/post_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/usecases/usecase.dart';
import '../../../../common/utils/typedef.dart';
import '../repositories/post_repository.dart';

@injectable
class GetSavedAllPosts implements UseCaseWithoutParams<List<PostEntity>> {
  final PostRepository repository;

  GetSavedAllPosts(this.repository);

  @override
  EitherFuture<List<PostEntity>> call() async {
    final posts = await repository.getSavedAllPosts();
    return right(posts);
  }
}
