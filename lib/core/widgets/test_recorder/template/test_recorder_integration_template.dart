import 'package:flutter_clean_architecture/core/widgets/test_recorder/model/test_record.dart';

final class TestRecorderIntegrationTemplate {
  final String packageName;

  TestRecorderIntegrationTemplate({
    required this.packageName,
  });

  String template = '''
group('Test Group', () {
  testWidgets(
    'Test',
    (WidgetTester tester) async {
      #record
    },
  );
});
''';

  void addRecord(TestRecord record) {
    // Add record to template

    String recordTemplate = '';

    if (record.type == TestRecordType.gesture) {
      recordTemplate = '''
await tester.tap(find.byValueKey('${record.key}'));
await tester.pumpAndSettle(const Duration(seconds: 2));
''';
    } else if (record.type == TestRecordType.navigation) {
      recordTemplate = '''
await tester.tap(find.byValueKey('${record.key}'));
await tester.pumpAndSettle(const Duration(seconds: 2));
''';
    }

    recordTemplate = '''
$recordTemplate

#record
''';

    template = template.replaceFirst('#record', recordTemplate);
  }
}
