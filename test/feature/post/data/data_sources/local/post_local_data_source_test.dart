import 'package:flutter_clean_architecture/src/common/local_database/local_db_manager.dart';
import 'package:flutter_clean_architecture/src/feature/post/data/data_sources/local/post_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/local_db_manager_mock.dart';

void main() {
  late LocalDBManager localDBManager;
  late PostLocalDataSource dataSource;

  setUp(() {
    localDBManager = MockLocalDBManager();
  });
}
