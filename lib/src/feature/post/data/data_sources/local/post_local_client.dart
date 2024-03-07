import 'package:flutter_clean_architecture/src/common/local_database/db_client.dart';
import 'package:flutter_clean_architecture/src/feature/post/data/model/post_do.dart';
import 'package:injectable/injectable.dart';

@injectable
class PostLocalClient extends DBClient<PostDO> {
  PostLocalClient(super.localDBManager);
}
