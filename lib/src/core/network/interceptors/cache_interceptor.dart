// import 'package:dio/dio.dart';
// import 'package:injectable/injectable.dart';

// import '../cache/network_cache_manager.dart';

// /// Header'dan "cache-control" veya özel bir header bilgisi (örneğin "x-cacheable")
// /// alarak response'u cache'leyip, sonraki isteklerde cache'ten dönen cevabı
// /// kullanabilirsiniz. Burada basit bir örnek gösteriyoruz.
// @injectable
// class CacheInterceptor extends Interceptor {
//   final INetworkCacheManager _cacheManager;

//   /// Client-side cache duration in minutes
//   final int defaultCacheDuration;

//   CacheInterceptor(
//     this._cacheManager, {
//     this.defaultCacheDuration = 5,
//   });

//   @override
//   Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
//     if (options.method.toUpperCase() == 'GET') {
//       final cacheKey = _generateCacheKey(options);
//       final cachedResponse = await _cacheManager.getItem(cacheKey);

//       if (cachedResponse != null) {
//         return handler.resolve(cachedResponse);
//       }
//     }
//     return handler.next(options);
//   }

//   @override
//   Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
//     if (response.requestOptions.method.toUpperCase() == 'GET') {
//       final shouldCache = _shouldCacheResponse(response);
//       if (shouldCache) {
//         final cacheKey = _generateCacheKey(response.requestOptions);
//         final maxAge = _getMaxAge(response);

//         await _cacheManager.addItem(cacheKey, response, maxAge);
//       }
//     }
//     return handler.next(response);
//   }

//   String _generateCacheKey(RequestOptions options) {
//     final language = options.headers['Accept-Language'] ?? 'default';
//     return '${options.uri.toString()}_$language';
//   }

//   bool _shouldCacheResponse(Response response) {
//     // 1. Server-side cache control
//     final cacheControl = response.headers.value('cache-control');
//     if (cacheControl != null && cacheControl.contains('no-store')) {
//       return false;
//     }

//     // 2. Custom header for explicit cache control
//     final xCacheable = response.headers.value('x-cacheable');
//     if (xCacheable == 'true') {
//       return true;
//     }

//     // 3. Client-side cache control
//     final clientCache = response.requestOptions.extra['client-cache'];
//     if (clientCache == true) {
//       return true;
//     }

//     return false;
//   }

//   int _getMaxAge(Response response) {
//     // 1. Try to get max-age from cache-control header
//     final cacheControl = response.headers.value('cache-control');
//     if (cacheControl != null) {
//       final maxAgeMatch = RegExp(r'max-age=(\d+)').firstMatch(cacheControl);
//       if (maxAgeMatch != null) {
//         return int.parse(maxAgeMatch.group(1) ?? '0');
//       }
//     }

//     // 2. Try to get from custom header
//     final xCacheMaxAge = response.headers.value('x-cache-max-age');
//     if (xCacheMaxAge != null) {
//       return int.tryParse(xCacheMaxAge) ?? defaultCacheDuration * 60;
//     }

//     // 3. Use client-side cache duration
//     final clientCacheDuration = response.requestOptions.extra['cache-duration'];
//     if (clientCacheDuration is int) {
//       return clientCacheDuration;
//     }

//     // Default duration in seconds
//     return defaultCacheDuration * 60;
//   }
// }
