// ignore_for_file: always_use_package_imports

import 'package:dartz/dartz.dart';

import '../entities/failure.dart';

/// Useful when you don't want with fold go to inner function where if you have
/// async call, you won't be able to await the whole function anymore.
///
/// By checking isLeft() and then unpacking Failure with asLeft() and isRight() and
/// then casting the result with asRight() to a variable you can achieve the same
/// as with fold without creating inner functions.
extension DartzExtension<R> on Either<Failure, R> {
  Failure asLeft() => (this as Left).value;
  R asRight() => (this as Right).value;
}
