/// T, Realm'de kullanılan model sınıfını (örneğin UserRealmModel) temsil eder.
abstract class ILocalDatabase<T> {
  /// Lokal veritabanına bir [T] kaydet veya güncelle
  Future<void> save(T item);

  /// Lokal veritabanına bir [T] listesi kaydet veya güncelle
  Future<void> saveAll(List<T> items);

  /// [id] değerine göre tek bir kaydı getir
  Future<T?> getById(String id);

  /// Tüm kayıtları getir
  Future<List<T>> getAll();

  /// [id] değerine göre bir kaydı sil
  Future<void> delete(String id);

  /// Tüm kayıtları sil
  Future<void> clearAll();
}
