import 'package:flutter_clean_architecture/core/usecases/usecase.dart';
import 'package:flutter_clean_architecture/core/utils/typedef.dart';
import 'package:flutter_clean_architecture/feature/post/domain/entities/post_entity.dart';
import 'package:flutter_clean_architecture/feature/post/domain/repositories/post_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllPosts implements UseCaseWithoutParams<List<PostEntity>> {
  final PostRepository _repository;
  GetAllPosts(this._repository);

  @override
  EitherFuture<List<PostEntity>> call() async {
    return _repository.getAll();
  }
}
