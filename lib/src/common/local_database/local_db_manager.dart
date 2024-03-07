import 'dart:async';

import 'package:flutter_clean_architecture/src/core/enums/env.dart';
import 'package:flutter_clean_architecture/src/feature/post/data/model/post_do.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

@lazySingleton
class LocalDBManager {
  late Isar isar;

  Completer<void> initializedCompleter = Completer<void>();

  Future<void> init([Env? env]) async {
    String path = ".";

    if (env != Env.test) {
      final dir = await getApplicationDocumentsDirectory();
      path = dir.path;
    }

    isar = await Isar.open(
      [PostDOSchema],
      directory: path,
    );
    initializedCompleter.complete();
  }

  Future<void> dispose([bool deleteFromDisk = false]) async {
    await isar.close(deleteFromDisk: deleteFromDisk);
  }
}
