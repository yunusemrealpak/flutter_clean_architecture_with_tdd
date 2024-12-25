import 'package:dio/dio.dart';

/// Header'dan "cache-control" veya özel bir header bilgisi (örneğin "x-cacheable")
/// alarak response'u cache'leyip, sonraki isteklerde cache'ten dönen cevabı
/// kullanabilirsiniz. Burada basit bir örnek gösteriyoruz.
class CacheInterceptor extends Interceptor {
  // Basit bir in-memory cache örneği. İsterseniz bir "CacheManager" sınıfına
  // da devredebilirsiniz.
  final Map<String, Response> _cache = {};

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Örnek: GET isteklerinde cache kontrolü
    if (options.method.toUpperCase() == 'GET') {
      // Key: URL + query param
      final cacheKey = options.uri.toString();
      if (_cache.containsKey(cacheKey)) {
        // Cache varsa direkt dönebileceğimiz bir mekanizma (isteğe bağlı).
        final cachedResponse = _cache[cacheKey];
        if (cachedResponse != null) {
          return handler.resolve(
            cachedResponse..requestOptions = options,
          );
        }
      }
    }
    return handler.next(options);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    // Response'da cache'lenebilir olup olmadığına bak
    final cacheControl = response.headers.value('cache-control') ?? '';
    // Örnek olarak "public, max-age=120" gibi bir format
    if (cacheControl.isNotEmpty || response.headers.value('x-cacheable') == 'true') {
      final cacheKey = response.requestOptions.uri.toString();
      // Cache süre yönetimini basit tutuyoruz; gerçek projede
      // cacheControl parse edilerek time-to-live ayarlanabilir.
      _cache[cacheKey] = response;
    }
    return handler.next(response);
  }
}
