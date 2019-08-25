class Either<First, Second> {
  final First first;
  final Second second;

  Either._(this.first, this.second);

  factory Either.withSuccess(Second second) {
    return Either._(null, second);
  }

  factory Either.withError(First first) {
    return Either._(first, null);
  }

  bool get hasSecond => second != null;

  bool get hasFirst => first != null && second == null;
}
