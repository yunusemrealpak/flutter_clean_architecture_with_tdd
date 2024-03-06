import '../../../../core/utils/typedef.dart';
import '../entities/post_entity.dart';

abstract interface class PostRepository {
  EitherFuture<List<PostEntity>> getAll();
  EitherFuture<PostEntity> getById(int id);
  Future<PostEntity> createPost(PostEntity post);
}
