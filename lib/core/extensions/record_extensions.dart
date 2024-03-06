extension RecordExtension<L, R> on (L, R) {
  E fold<E>(E Function(L? l) left, E Function(R r) right) {
    if (this.$1 == null) {
      return right(this.$2);
    } else {
      return left(this.$1);
    }
  }

  L get left => this.$1;
  R get right => this.$2;
}
