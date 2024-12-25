/// Token'ın nereden alınacağını soyutlayan arayüz.
/// Örneğin, SharedPreferences veya SecureStorage veya Memory vb. implementasyonlar
/// yaparak projeden projeye değiştirebilirsiniz.
abstract class ITokenProvider {
  Future<String?> getToken();
  Future<void> clearToken(); // Token silmek isterseniz vb.
}
