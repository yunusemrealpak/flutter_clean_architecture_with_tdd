enum TestRecordType { gesture, navigation }

final class TestRecord {
  final String? key;
  final String? navigationRoute;
  final TestRecordType type;

  TestRecord(
      {required this.key, required this.navigationRoute, required this.type});
}
