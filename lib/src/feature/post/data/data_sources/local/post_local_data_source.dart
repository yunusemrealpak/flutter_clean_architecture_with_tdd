import 'package:flutter_clean_architecture/src/feature/post/data/data_sources/local/post_local_client.dart';
import 'package:flutter_clean_architecture/src/feature/post/data/model/post_do.dart';
import 'package:injectable/injectable.dart';

abstract interface class PostLocalDataSource {
  Future<List<PostDO>> getAll();
  Future<int> insertOrUpdate(PostDO post);
  Future<List<int>> insertOrUpdateList(List<PostDO> posts);
  Future<bool> delete(int id);
  Future<int> deleteAll();
}

@LazySingleton(as: PostLocalDataSource)
class PostLocalDataSourceImpl implements PostLocalDataSource {
  final PostLocalClient _client;

  PostLocalDataSourceImpl(this._client);

  @override
  Future<List<PostDO>> getAll() async {
    return _client.getAll();
  }

  @override
  Future<int> insertOrUpdate(PostDO post) {
    return _client.insertOrUpdate(post);
  }

  @override
  Future<List<int>> insertOrUpdateList(List<PostDO> posts) async {
    return _client.insertOrUpdateList(posts);
  }

  @override
  Future<bool> delete(int id) {
    return _client.delete(id);
  }

  @override
  Future<int> deleteAll() {
    return _client.deleteAll();
  }
}
