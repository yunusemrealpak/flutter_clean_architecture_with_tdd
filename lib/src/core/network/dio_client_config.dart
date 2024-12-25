import 'package:flutter/foundation.dart';

import 'token/token_provider.dart';

/// DioClientConfig: Tüm ayarları tek bir yerden yönetebilmek için oluşturulan
/// konfigürasyon sınıfı.
///
/// - enableLogging: Log interceptor aktif mi?
/// - enableTokenInterceptor: Token interceptor aktif mi?
/// - enableEncryption: İstek/cevap şifreleme aktif mi?
/// - enableCaching: Cache interceptor aktif mi?
/// - baseUrl: Default API host adresi.
/// - tokenProvider: Token nereden sağlanacak? (ör: SharedPreferences, SecureStorage)
/// - onUnauthorized: 401 durumunda ne yapılacak? (ör: login ekranına yönlendir)
class DioClientConfig {
  final bool enableLogging;
  final bool enableTokenInterceptor;
  final bool enableCaching;
  final String baseUrl;
  final ITokenProvider? tokenProvider;
  final VoidCallback? onUnauthorized;

  /// Encryption ayarları
  final bool enableEncryption;
  final bool forceEncryptionOnServerResponse;
  final String? encryptionKeyBase64;
  final String? encryptionIVBase64;
  final List<String>? skipEncryptionForPaths;

  DioClientConfig({
    this.enableLogging = false,
    this.enableTokenInterceptor = false,
    this.enableCaching = false,
    this.baseUrl = '',
    this.tokenProvider,
    this.onUnauthorized,

    /// Encryption ayarları
    this.enableEncryption = false,
    this.forceEncryptionOnServerResponse = false,
    this.encryptionKeyBase64,
    this.encryptionIVBase64,
    this.skipEncryptionForPaths,
  });
}
