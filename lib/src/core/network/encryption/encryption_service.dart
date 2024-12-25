import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;

/// EncryptionService:
/// - AES-256 CBC modunda şifreleme/deşifreleme.
/// - 'magicHeader' ile şifrelenmiş veriyi işaretleyebilir,
///   deşifre aşamasında da aynı işareti kontrol edebilirsiniz.
///   (Örn: 'ENCRYPTED:::' gibi bir prefix)
///
/// - AESKey (32 byte) ve IV (16 byte) Base64 formatında alınır.
/// - Key/IV uzunlukları kontrol edilir.
///
/// Örnek kullanım:
///
///   final service = EncryptionService(
///     base64Key: '...32-byte-key...',
///     base64IV: '...16-byte-iv...',
///   );
///
class EncryptionService {
  late final encrypt.Encrypter _encrypter;
  late final encrypt.IV _iv;

  /// Şifreli data’nın başında bulunacak bir prefix.
  /// Servis-client arasında önceden anlaşılan bir işaret.
  /// Örnek: 'ENCRYPTED:::'
  final String magicHeader;

  EncryptionService({
    required String base64Key,
    required String base64IV,
    this.magicHeader = 'ENCRYPTED:::',
  }) {
    final keyBytes = base64.decode(base64Key);
    final ivBytes = base64.decode(base64IV);

    if (keyBytes.length != 32) {
      throw ArgumentError('AES-256 için 32 byte uzunluğunda bir key gerekiyor.');
    }
    if (ivBytes.length != 16) {
      throw ArgumentError('AES CBC modu için 16 byte IV gerekiyor.');
    }

    final key = encrypt.Key(keyBytes);
    _iv = encrypt.IV(ivBytes);

    // AES-256 CBC + PKCS7 padding
    _encrypter = encrypt.Encrypter(
      encrypt.AES(
        key,
        mode: encrypt.AESMode.cbc,
        padding: 'PKCS7',
      ),
    );
  }

  /// plainText: Şifrelemek istediğiniz düz metin (örn. JSON string).
  /// Dönüş: Şifrelenmiş metin (base64) + magicHeader prefix'i.
  String encryptData(String plainText) {
    final encrypted = _encrypter.encrypt(plainText, iv: _iv);
    final encryptedBase64 = encrypted.base64;

    // Magic header + base64
    // Böylece verinin gerçekten şifreli mi olduğunu,
    // payload'ın başlangıcındaki 'ENCRYPTED:::' ifadesinden anlarız.
    return '$magicHeader$encryptedBase64';
  }

  /// encryptedText: magicHeader + base64 şekilde şifreli veri.
  /// Dönüş: Deşifre edilmiş orijinal metin (plainText).
  String decryptData(String encryptedText) {
    if (!isDataEncrypted(encryptedText)) {
      // Eğer magicHeader yoksa, "veri şifreli değil" olarak kabul edebilir
      // veya hata fırlatabilirsiniz (iş mantığına göre).
      throw ArgumentError('Decrypt edilmek istenen veri şifreli gibi görünmüyor!');
    }

    // Magic header'ı çıkar
    final base64Str = encryptedText.substring(magicHeader.length);

    // Base64 string'i AES ile çözüyoruz
    return _encrypter.decrypt64(base64Str, iv: _iv);
  }

  /// Verinin başında magicHeader var mı diye kontrol ederek
  /// 'içerik bazlı' bir şifreli kontrolü.
  bool isDataEncrypted(String data) {
    return data.startsWith(magicHeader);
  }
}
