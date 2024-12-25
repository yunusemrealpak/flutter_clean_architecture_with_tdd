enum Env {
  test("test"),
  dev("dev"),
  stag("stag"),
  prod("prod");

  const Env(this.value);
  final String value;

  static Env fromValue(int value) {
    return Env.values.firstWhere((el) => el.value == value);
  }
}
