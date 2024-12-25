import 'package:flutter_clean_architecture/src/core/database/i_local_database.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

import 'isar_service.dart';

/// T, Isar modeliniz (örneğin NetworkCacheItem).
///
/// Isar ile çalışırken `T` bir Isar collection'ı olmalıdır.
@Injectable(as: ILocalDatabase)
class IsarLocalDatabase<T> implements ILocalDatabase<T> {
  final IsarService _isarService;
  late final IsarCollection<T> _collection;

  IsarLocalDatabase(this._isarService) {
    _collection = _isarService.isar.collection<T>();
  }

  @override
  Future<void> saveAll(List<T> items) async {
    await _isarService.isar.writeTxn(() async {
      await _collection.putAll(items);
    });
  }

  @override
  Future<void> save(T item) async {
    await _isarService.isar.writeTxn(() async {
      await _collection.put(item);
    });
  }

  @override
  Future<T?> getById(String id) async {
    return _collection.get(int.parse(id));
  }

  @override
  Future<List<T>> getAll() async {
    return _collection.where().findAll();
  }

  @override
  Future<void> delete(String id) async {
    await _isarService.isar.writeTxn(() async {
      await _collection.delete(int.parse(id));
    });
  }

  @override
  Future<void> clearAll() async {
    await _isarService.isar.writeTxn(() async {
      await _collection.clear();
    });
  }
}
