import 'model/test_record.dart';

final class TestRecorderService {
  static final TestRecorderService _instance = TestRecorderService._internal();
  static TestRecorderService get instance => _instance;
  TestRecorderService._internal();

  final List<TestRecord> _records = [];

  void addRecord(TestRecord record) {
    _records.add(record);
  }

  List<TestRecord> getRecords() {
    return _records;
  }

  void convertRecordsToIntegrationTest() {
    // Convert records to integration test
  }

  void clearRecords() {
    _records.clear();
  }
}
