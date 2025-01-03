import 'package:flutter_clean_architecture/src/infrastructure/common/utils/typedef.dart';

abstract interface class UseCase<Type, Params> {
  EitherFuture<Type> call(Params params);
}

abstract interface class UseCaseWithoutParams<Type> {
  EitherFuture<Type> call();
}
