import 'package:fluttercompareapp/common/domain/notifiers/base_state.dart';
import 'package:fluttercompareapp/common/domain/notifiers/base_state_notifier.dart';
import 'package:fluttercompareapp/features/auth/login/data/repositories/auth_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, BaseState<bool>>(
  (ref) => AuthNotifier(
    ref.watch(authRepositoryProvider),
    ref,
  ),
);

class AuthNotifier extends BaseStateNotifier<bool> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository, super.ref);

  Future<void> listenAuthChanges() async {
    _authRepository.subscribeToAuthChanges().listen(
      (user) {
        logInfo('matej1 $user');
        if (user != null) {
          state = const BaseState.data(true);
        } else {
          state = const BaseState.data(false);
        }
      },
    );
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    state = const BaseState.data(false);
  }
}
