/*
 * Copyright (c) 2019.
 *           ______             _
 *          |____  |           | |
 *  _ __ ___    / / __ ___   __| |_ __ __ _
 * | '_ ` _ \  / / '_ ` _ \ / _` | '__/ _` |
 * | | | | | |/ /| | | | | | (_| | | | (_| |
 * |_| |_| |_/_/ |_| |_| |_|\__,_|_|  \__,_|
 *
 *
 *
 *
 */

class Either<First, Second> {
  final First first;
  final Second second;

  Either._(this.first, this.second);

  factory Either.withSuccess(First first) {
    return Either._(first, null);
  }

  factory Either.withError(Second second) {
    return Either._(null, second);
  }

  bool get hasSecond => second != null;

  bool get hasFirst => first != null && second == null;
}
