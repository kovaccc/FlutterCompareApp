import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:fluttercompareapp/common/domain/either_failure_or.dart';
import 'package:fluttercompareapp/common/domain/entities/failure.dart';

mixin ErrorToFailureMixin {
  EitherFailureOr<T> execute<T>(
    EitherFailureOr<T> Function() function, {
    String? failureTitle,
  }) async {
    try {
      return await function();
    } catch (err, stackTrace) {
      log(err.toString());
      log(stackTrace.toString());
      return Left(Failure.generic(
        title: failureTitle,
        error: err,
        stackTrace: stackTrace,
      ));
    }
  }
}
