import 'package:dartz/dartz.dart';

extension DartzExtension<L, R> on Either<L, R> {
  L? get left => fold((l) => l, (_) => null);
  R? get right => fold((_) => null, (r) => r);
}
