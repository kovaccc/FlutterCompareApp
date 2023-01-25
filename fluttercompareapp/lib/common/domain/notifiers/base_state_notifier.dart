// ignore_for_file: always_use_package_imports

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../either_failure_or.dart';
import '../entities/failure.dart';
import '../providers/global_failure_provider.dart';
import '../providers/global_loading_provider.dart';
import 'base_state.dart';

typedef PreHandleData<T> = bool Function(T data);
typedef PreHandleFailure = bool Function(Failure failure);

abstract class BaseStateNotifier<DataState>
    extends StateNotifier<BaseState<DataState>> {
  final Ref ref;

  BaseStateNotifier(this.ref) : super(const BaseState.initial());

  /// Executes received [function] with additional parameters to control if loading state should be set while executing [function] by providing [withLoadingState] param.
  ///
  /// Also if you want loading shown over all screens, it can se set via [globalLoading] param.
  /// To show failure over all screens instead changing the state, it can be set via [globalFailure] params.
  /// To filter and control which data will update the state, [onDataReceived] callback can be passed. Alternatively,
  /// if callback always return false, custom data handling can be implemented.
  /// To filter and control which failure will update the state or be shown globally, [onFailureOccurred] callback can be
  /// passed. Similar to [onDataReceived] if always returned false, custom failure handling can be implemented.
  @protected
  Future execute(
    EitherFailureOr<DataState> function, {
    PreHandleData<DataState>? onDataReceived,
    PreHandleFailure? onFailureOccurred,
    bool withLoadingState = true,
    bool globalLoading = false,
    bool globalFailure = true,
  }) async {
    _setLoading(withLoadingState, globalLoading);

    final result = await function;

    await _handleResult(
      result,
      onDataReceived,
      onFailureOccurred,
      withLoadingState,
      globalLoading,
      globalFailure,
    );
  }

  /// Executes received stream [function] with additional parameters to control if loading state should be set while executing [function] by providing [withLoadingState] param.
  /// Usage is the same as the [execute] method with the main difference in number of [function] results (and consequently number of state updates) as it is a stream of data
  @protected
  Future<void> executeStreamed(
    StreamFailureOr<DataState> function, {
    PreHandleData<DataState>? onDataReceived,
    PreHandleFailure? onFailureOccurred,
    bool withLoadingState = true,
    bool globalLoading = false,
    bool globalFailure = true,
  }) async {
    _setLoading(withLoadingState, globalLoading);

    await for (final result in function) {
      await _handleResult(
        result,
        onDataReceived,
        onFailureOccurred,
        withLoadingState,
        globalLoading,
        globalFailure,
      );
    }
  }

  ///Show [BaseLoadingIndicator] above the entire app
  @protected
  void showGlobalLoading() =>
      ref.read(globalLoadingProvider.notifier).update((state) => true);

  ///Clear [BaseLoadingIndicator]
  @protected
  void clearGlobalLoading() =>
      ref.read(globalLoadingProvider.notifier).update((state) => false);

  @protected
  void setGlobalFailure(Failure? failure) {
    clearGlobalLoading();
    ref
        .read(globalFailureProvider.notifier)
        .update((state) => failure?.copyWith(uniqueKey: UniqueKey()));
  }

  Future<void> _handleResult(
    Either<Failure, DataState> result,
    PreHandleData<DataState>? onDataReceived,
    PreHandleFailure? onFailureOccurred,
    bool withLoadingState,
    bool globalLoading,
    bool globalFailure,
  ) async {
    result.fold(
      (failure) => _onFailure(
        failure,
        onFailureOccurred,
        withLoadingState,
        globalFailure,
      ),
      (data) => _onData(
        data,
        onDataReceived,
        withLoadingState,
      ),
    );
  }

  void _onFailure(
    Failure failure,
    PreHandleFailure? onFailureOccurred,
    bool withLoadingState,
    bool globalFailure,
  ) {
    final shouldProceedWithFailure = onFailureOccurred?.call(failure) ?? true;
    if (!shouldProceedWithFailure || globalFailure) {
      _unsetLoading(withLoadingState);
    }
    if (shouldProceedWithFailure) {
      globalFailure
          ? setGlobalFailure(failure)
          : state = BaseState.error(failure);
    }
  }

  void _onData(
    DataState data,
    PreHandleData<DataState>? onDataReceived,
    bool withLoadingState,
  ) {
    final shouldUpdateState = onDataReceived?.call(data) ?? true;
    _unsetLoading(shouldUpdateState ? false : withLoadingState);
    if (shouldUpdateState) {
      state = BaseState.data(data);
    }
  }

  ///Shows global loading if [globalLoading] == true
  ///Set [withLoadingState] == true if you want to change [BaseStateNotifier] state to [BaseState.loading]
  void _setLoading(bool withLoadingState, bool globalLoading) {
    if (withLoadingState) state = const BaseState.loading();
    if (globalLoading) showGlobalLoading();
  }

  ///Clears global loading
  ///Set [withLoadingState] == true if you want to reset [BaseStateNotifier] state to [BaseState.initial]
  void _unsetLoading(bool withLoadingState) {
    if (withLoadingState && state.whenOrNull(loading: () => true) == true) {
      state = const BaseState.initial();
    }

    clearGlobalLoading();
  }
}
