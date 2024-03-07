import 'package:flutter_clean_architecture/src/common/local_database/local_db_manager.dart';
import 'package:flutter_clean_architecture/src/feature/post/data/data_sources/local/post_local_client.dart';
import 'package:flutter_clean_architecture/src/feature/post/data/model/post_do.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late LocalDBManager localDBManager;
  late PostLocalClient client;

  setUpAll(() async {
    localDBManager = LocalDBManager();
    await localDBManager.init();
    client = PostLocalClient(localDBManager);
  });

  tearDownAll(() {
    localDBManager.dispose();
  });

  group('[PostLocalClient]', () {
    final isar = localDBManager.isar;
    final table = isar.collection<PostDO>();

    final tPostDO = PostDO(id: 1, title: 'title', body: 'body');

    test('should be able to insert data', () async {
      // arrange
      when(() => table.put(any())).thenAnswer((_) async => 1);

      final result = await client.insertOrUpdate(tPostDO);
      expect(result, equals(1));
    });
  });
}
