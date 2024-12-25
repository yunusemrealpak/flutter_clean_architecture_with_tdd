/// data/datasources/local/realm_datasource.dart
library;

import 'package:flutter_clean_architecture/src/core/database/i_local_database.dart';
import 'package:injectable/injectable.dart';
import 'package:realm/realm.dart';

/// T, Realm modeliniz (örneğin UserRealmModel).
///
/// Realm ile çalışırken `T extends RealmObjectBase` olması beklenir.
@Injectable(as: ILocalDatabase)
@Named.from(RealmLocalDatabase)
class RealmLocalDatabase<T extends RealmObject> implements ILocalDatabase<T> {
  late final Realm _realm;

  RealmLocalDatabase(Realm realm) {
    // Dışarıdan konfigüre edilmiş bir Realm örneğini alıyoruz
    _realm = realm;
  }

  @override
  Future<void> saveAll(List<T> items) async {
    _realm.write(() {
      _realm.addAll<T>(items, update: true);
    });
  }

  @override
  Future<void> save(T item) async {
    // realm.write ile transaction başlatıp veriyi ekliyoruz/güncelliyoruz.
    _realm.write(() {
      // update: true => Aynı primaryKey'e sahip kayıt varsa günceller
      _realm.add(item, update: true);
    });
  }

  @override
  Future<T?> getById(String id) async {
    // find<T> fonksiyonu ile primaryKey'i id olan kaydı arar. Yoksa null döner.
    final record = _realm.find<T>(id);
    return record;
  }

  @override
  Future<List<T>> getAll() async {
    // .all<T>() => T tipindeki tüm kayıtları verir
    return _realm.all<T>().toList();
  }

  @override
  Future<void> delete(String id) async {
    final item = _realm.find<T>(id);
    if (item != null) {
      _realm.write(() {
        _realm.delete(item);
      });
    }
  }

  @override
  Future<void> clearAll() async {
    _realm.write(() {
      _realm.deleteAll<T>();
    });
  }
}
