extension MapExtensions<K, V> on Map<K, V> {
  bool existsAllKeys(List<K> keys) {
    return keys.every((key) => containsKey(key));
  }
}
