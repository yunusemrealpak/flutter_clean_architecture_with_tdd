// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:injectable/injectable.dart';

// import '../model/network_cache_item.dart';

// abstract class INetworkCacheManager {
//   Future<void> init();
//   Future<void> addItem(String key, Response response, int maxAge);
//   Future<Response?> getItem(String key);
//   Future<void> removeItem(String key);
//   Future<void> clearCache();
//   Future<bool> containsKey(String key);
// }

// @LazySingleton(as: INetworkCacheManager)
// class NetworkCacheManager implements INetworkCacheManager {
//   final IsarService _isarService;

//   NetworkCacheManager(this._isarService);

//   @override
//   Future<void> init() async {
//     // IsarService zaten initialize edilmiş olacak
//   }

//   @override
//   Future<void> addItem(String key, Response response, int maxAge) async {
//     final cacheItem = NetworkCacheItem()
//       ..key = key
//       ..responseData = jsonEncode(response.data)
//       ..headers = jsonEncode(response.headers.map.map(
//         (key, value) => MapEntry(key, value.join(',')),
//       ))
//       ..statusCode = response.statusCode ?? 200
//       ..statusMessage = response.statusMessage
//       ..requestOptions = jsonEncode({
//         'method': response.requestOptions.method,
//         'path': response.requestOptions.path,
//         'baseUrl': response.requestOptions.baseUrl,
//         'headers': response.requestOptions.headers,
//         'queryParameters': response.requestOptions.queryParameters,
//       })
//       ..timestamp = DateTime.now()
//       ..maxAge = maxAge;

//     await _isarService.isar.writeTxn(() async {
//       await _isarService.isar.collection<NetworkCacheItem>().put(cacheItem);
//     });
//   }

//   @override
//   Future<Response?> getItem(String key) async {
//     final cacheItem = await _isarService.isar.networkCacheItems.getByKey(key);

//     if (cacheItem == null) return null;

//     if (cacheItem.isExpired()) {
//       await removeItem(key);
//       return null;
//     }

//     try {
//       final requestOptionsMap = jsonDecode(cacheItem.requestOptions) as Map<String, dynamic>;
//       final requestOptions = RequestOptions(
//         method: requestOptionsMap['method'] as String,
//         path: requestOptionsMap['path'] as String,
//         baseUrl: requestOptionsMap['baseUrl'] as String,
//         headers: Map<String, dynamic>.from(requestOptionsMap['headers'] as Map),
//         queryParameters: Map<String, dynamic>.from(requestOptionsMap['queryParameters'] as Map),
//       );

//       final headersMap = jsonDecode(cacheItem.headers) as Map<String, dynamic>;
//       final headers = Headers.fromMap(
//         headersMap.map((key, value) => MapEntry(key, [value as String])),
//       );

//       return Response(
//         requestOptions: requestOptions,
//         data: jsonDecode(cacheItem.responseData),
//         headers: headers,
//         statusCode: cacheItem.statusCode,
//         statusMessage: cacheItem.statusMessage,
//       );
//     } catch (e) {
//       await removeItem(key);
//       return null;
//     }
//   }

//   @override
//   Future<void> removeItem(String key) async {
//     await _isarService.isar.writeTxn(() async {
//       await _isarService.isar.networkCacheItems.deleteByKey(key);
//     });
//   }

//   @override
//   Future<void> clearCache() async {
//     await _isarService.isar.writeTxn(() async {
//       await _isarService.isar.collection<NetworkCacheItem>().clear();
//     });
//   }

//   @override
//   Future<bool> containsKey(String key) async {
//     final cacheItems = await _isarService.isar.collection<NetworkCacheItem>().getAllByKey([key]);

//     return cacheItems.any((item) => item?.key == key);
//   }
// }
