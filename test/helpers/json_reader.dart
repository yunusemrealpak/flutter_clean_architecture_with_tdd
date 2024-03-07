/// Create json reader from path
library;

import 'dart:convert';
import 'dart:io';

import 'package:flutter_clean_architecture/src/common/utils/typedef.dart';

class JsonReader {
  static DataMap readJson(String path) {
    var dir = Directory.current.path;

    if (dir.endsWith('/test')) {
      dir = dir.replaceAll('/test', '');
    }

    final file = File('$dir/test/$path');
    final jsonString = file.readAsStringSync();
    return json.decode(jsonString) as DataMap;
  }
}
