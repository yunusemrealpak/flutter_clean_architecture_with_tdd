import 'dart:convert';

import 'package:dio/dio.dart';

import '../encryption/encryption_service.dart';

/// EncryptionInterceptor:
/// - İstek gövdesinde (request body) AES şifreleme.
/// - Response gövdesinde AES deşifreleme.
/// - Şifreli olup olmadığını hem header’dan (x-encrypted: true)
///   hem magicHeader’dan anlayabilir.
///
/// - encryptRequestBody: İstek data’sını şifreleyelim mi?
/// - decryptResponseBody: Gelen cevabı şifreli ise deşifreleyelim mi?
/// - forceEncryptionOnServerResponse: true ise, server’ın x-encrypted: true
///   header’ı koymasını “bekleriz”, yoksa hata veya fallback gibi davranabiliriz.
class EncryptionInterceptor extends Interceptor {
  final EncryptionService encryptionService;
  final bool encryptRequestBody;
  final bool decryptResponseBody;
  final bool forceEncryptionOnServerResponse;
  final List<String>? skipEncryptionForPaths;
  // Bazı endpoint’leri hariç tutmak isterseniz (örn. /auth/fileupload gibi).

  EncryptionInterceptor({
    required this.encryptionService,
    this.encryptRequestBody = true,
    this.decryptResponseBody = true,
    this.forceEncryptionOnServerResponse = false,
    this.skipEncryptionForPaths,
  });

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Örnek: Bazı endpoint’leri hariç tutmak
    if (skipEncryptionForPaths != null && skipEncryptionForPaths!.contains(options.path)) {
      return handler.next(options);
    }

    // Multi-part (dosya yükleme) gibi durumları da hariç tutmak isteyebilirsiniz:
    final contentType = options.contentType?.toLowerCase() ?? '';
    if (contentType.contains('multipart/form-data')) {
      // Dosya upload gibi durumlarda, opsiyonel olarak şifreleme atlanabilir.
      return handler.next(options);
    }

    // Request body şifreleme aktifse
    if (encryptRequestBody && options.data != null) {
      try {
        // 1) data String ise direkt
        if (options.data is String) {
          final plainText = options.data as String;
          final encryptedText = encryptionService.encryptData(plainText);
          options.data = encryptedText;

          // 2) data Map veya List ise JSON string’e çevirip şifrele
        } else if (options.data is Map || options.data is List) {
          // JSON encode
          final jsonString = jsonEncode(options.data);
          final encryptedText = encryptionService.encryptData(jsonString);
          options.data = encryptedText;
        }
        // 3) Farklı tipler (FormData dışındaki binary, vs.) -> yaklaşıma göre ele alınabilir

        // Server’a şifreli gittiğini belirtmek için bir header ekleyebiliriz:
        // (Bu, server tarafında "bu payload şifreli, önce AES ile aç" diye sinyal olabilir.)
        options.headers['x-encrypted'] = 'true';
      } catch (e) {
        print('[EncryptionInterceptor] Request body encrypt hatası: $e');
      }
    }

    handler.next(options);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    // Response tarafı şifreli mi?
    // 1) Header’dan kontrol
    final isServerSaysEncrypted = response.headers.value('x-encrypted') == 'true';

    if (forceEncryptionOnServerResponse && !isServerSaysEncrypted) {
      // Server’ın şifreli döneceğini “garanti” diyorsak ve gelmemişse
      // hata fırlatabilir veya fallback bir davranış belirleyebiliriz
      print('[EncryptionInterceptor] Beklenen şifreli yanıt gelmedi!');
      // Örnek: ister handler.next(response) diyerek aynen devam edebilirsiniz,
      // ister bir hata fırlatabilirsiniz. Burada sadece uyarı basıyoruz.
    }

    // decryptResponseBody => false ise, deşifre yapmadan aynen geçeriz
    if (!decryptResponseBody) {
      return handler.next(response);
    }

    if (response.data != null && response.data is String) {
      final responseString = response.data as String;

      // 2) magicHeader kontrolü (içerik bazlı)
      final isDataHasMagicHeader = encryptionService.isDataEncrypted(responseString);

      // Hem "server header = true" hem "magicHeader var" -> muhtemelen şifreli
      // Tek başına magicHeader’ı da yeterli kabul edebilirsiniz.
      if (isServerSaysEncrypted || isDataHasMagicHeader) {
        try {
          final decrypted = encryptionService.decryptData(responseString);

          // Deşifre edilmiş sonuç JSON olabilir, metin olabilir...
          // Örnek: JSON parse deneyelim, JSON değilse yakalayacağız.
          dynamic finalData;
          try {
            finalData = jsonDecode(decrypted);
          } catch (jsonError) {
            // JSON değilse plain string olarak bırakabiliriz
            finalData = decrypted;
          }

          response.data = finalData;
        } catch (e) {
          print('[EncryptionInterceptor] Response decrypt hatası: $e');
          // Burada isterseniz response.data’yı null yapabilir,
          // isterseniz orijinal responseString’i bırakabilirsiniz.
        }
      } else {
        // magicHeader yok, x-encrypted: false => data şifreli değil gibi davran.
      }
    }

    handler.next(response);
  }
}
