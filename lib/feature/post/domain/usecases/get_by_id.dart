import 'package:flutter_clean_architecture/core/usecases/usecase.dart';
import 'package:flutter_clean_architecture/core/utils/typedef.dart';
import 'package:flutter_clean_architecture/feature/post/domain/entities/post_entity.dart';
import 'package:flutter_clean_architecture/feature/post/domain/repositories/post_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetById implements UseCase<PostEntity, int> {
  final PostRepository _repository;
  GetById(this._repository);

  @override
  EitherFuture<PostEntity> call(int params) async {
    return _repository.getById(params);
  }
}
