import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/network/model/network_cache_item.dart';

@singleton
class IsarService {
  late final Isar isar;

  @PostConstruct()
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NetworkCacheItemSchema],
      directory: dir.path,
    );
  }

  Future<void> dispose() async {
    await isar.close();
  }
}
