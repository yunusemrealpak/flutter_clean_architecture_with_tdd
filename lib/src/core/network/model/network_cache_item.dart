class NetworkCacheItem {
  late String key;

  late String responseData;
  late String headers;
  late int statusCode;
  String? statusMessage;
  late String requestOptions;
  late DateTime timestamp;
  late int maxAge;

  bool isExpired() {
    final now = DateTime.now();
    final expirationTime = timestamp.add(Duration(seconds: maxAge));
    return now.isAfter(expirationTime);
  }
}
