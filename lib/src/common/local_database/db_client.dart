import 'package:flutter_clean_architecture/src/common/local_database/db_object.dart';
import 'package:flutter_clean_architecture/src/common/local_database/local_db_manager.dart';
import 'package:isar/isar.dart';

abstract class DBClient<T extends DBObject> {
  late final LocalDBManager _localDBManager;
  late Isar db;
  late IsarCollection<T> table;
  DBClient(this._localDBManager) {
    init();
  }

  Future init() async {
    await _localDBManager.initializedCompleter.future;
    db = _localDBManager.isar;
    table = db.collection<T>();
  }

  Future<List<T>> getAll() async {
    return table.where().findAll();
  }

  Future<bool> delete(int id) {
    return table.delete(id);
  }

  Future<int> deleteAll() {
    return table.where().deleteAll();
  }

  Future<int> insertOrUpdate(T data) {
    return db.writeTxn<int>(() async {
      return table.put(data);
    });
  }

  Future<List<int>> insertOrUpdateList(List<T> list) async {
    return db.writeTxn<List<int>>(() async {
      return table.putAll(list);
    });
  }
}
