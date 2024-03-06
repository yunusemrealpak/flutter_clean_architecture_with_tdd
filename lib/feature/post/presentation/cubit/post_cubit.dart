import 'package:injectable/injectable.dart';

import '../../../_common/cubit/base_cubit.dart';
import 'post_state.dart';

@injectable
class PostCubit extends BaseCubit<PostState> {
  PostCubit() : super();

  void init() {}
}
