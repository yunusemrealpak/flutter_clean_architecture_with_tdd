import 'package:isar/isar.dart';

part 'network_cache_item.g.dart';

@Collection()
class NetworkCacheItem {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String key;

  late String responseData;
  late String headers;
  late int statusCode;
  String? statusMessage;
  late String requestOptions;
  @Index()
  late DateTime timestamp;
  late int maxAge;

  bool isExpired() {
    final now = DateTime.now();
    final expirationTime = timestamp.add(Duration(seconds: maxAge));
    return now.isAfter(expirationTime);
  }
}
