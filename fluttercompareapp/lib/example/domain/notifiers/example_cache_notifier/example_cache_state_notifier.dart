// ignore_for_file: always_use_package_imports

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../common/domain/notifiers/base_state.dart';
import '../../../../common/domain/notifiers/base_state_notifier.dart';
import '../../../../common/domain/result.dart';
import '../../../data/repositories/example_repository.dart';

final exampleCacheNotifierProvider =
    StateNotifierProvider<ExampleCacheStateNotifier, BaseState<Result<String>>>(
  (ref) => ExampleCacheStateNotifier(ref.watch(exampleRepositoryProvider), ref),
);

class ExampleCacheStateNotifier extends BaseStateNotifier<Result<String>> {
  final ExampleRepository _exampleRepository;

  ExampleCacheStateNotifier(this._exampleRepository, super.ref);

  //Example usage of streamed method of fetching data
  //Usage could be to load data from cache then from API, but in this case
  //we can differentiate between network and cache results by the result type
  Future getSomeStringsStreamed() => executeStreamed(
        _exampleRepository.getSomeResultStringsStreamed(),
      );
}
