// ignore_for_file: always_use_package_imports

import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/data/api_client.dart';
import '../../../common/data/mappers/entity_mapper.dart';
import '../../../common/data/providers.dart';
import '../../../common/domain/either_failure_or.dart';
import '../../../common/domain/entities/failure.dart';
import '../../../common/domain/result.dart';
import '../../domain/entities/example_user.dart';
import '../mappers/example_user_entity_mapper.dart';
import '../models/example_user_response.dart';

final exampleRepositoryProvider = Provider<ExampleRepository>(
  (ref) => ExampleRepositoryImp(
    ref.watch(apiClientProvider),
    ref.watch(exampleUserEntityMapperProvider),
  ),
);

abstract class ExampleRepository {
  EitherFailureOr<String> getSomeString();

  EitherFailureOr<String> getSomeOtherString();

  StreamFailureOr<String> getSomeStringsStreamed();

  StreamFailureOrResult<String> getSomeResultStringsStreamed();

  EitherFailureOr<ExampleUser> apiCallExample();
}

class ExampleRepositoryImp implements ExampleRepository {
  final ApiClient _apiClient;
  final EntityMapper<ExampleUser, ExampleUserResponse> _userMapper;

  ExampleRepositoryImp(
    this._apiClient,
    this._userMapper,
  );

  @override
  EitherFailureOr<ExampleUser> apiCallExample() async {
    try {
      final userResponse = await _apiClient.getUser();
      final user = _userMapper(userResponse);
      return Right(user);
    } catch (error, stackTrace) {
      return Left(
        Failure.generic(error: error, stackTrace: stackTrace),
      );
    }
  }

  @override
  EitherFailureOr<String> getSomeOtherString() async {
    await Future.delayed(const Duration(seconds: 3));
    if (Random().nextBool()) {
      return Right(Random().nextBool() ? 'Some sentence' : '');
    } else {
      return Left(Failure.generic());
    }
  }

  @override
  StreamFailureOr<String> getSomeStringsStreamed() async* {
    yield const Right('Some sentence from cache');

    await Future.delayed(const Duration(seconds: 3));
    yield const Right('Some sentence from network');
  }

  @override
  StreamFailureOrResult<String> getSomeResultStringsStreamed() async* {
    yield Right(Result.cache('Some sentence'));

    await Future.delayed(const Duration(seconds: 3));
    yield Right(Result.network('Some sentence'));
  }

  @override
  EitherFailureOr<String> getSomeString() async {
    await Future.delayed(const Duration(seconds: 3));
    if (Random().nextBool()) {
      return const Right('some sentence');
    } else {
      return Left(Failure.generic());
    }
  }
}
