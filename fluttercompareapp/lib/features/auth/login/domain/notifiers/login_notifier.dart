import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttercompareapp/features/auth/login/data/repositories/auth_repository.dart';
import 'package:fluttercompareapp/features/auth/login/forms/login_form.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:fluttercompareapp/common/domain/notifiers/base_state_notifier.dart';
import 'package:fluttercompareapp/common/domain/notifiers/base_state.dart';

final loginNotifierProvider =
    StateNotifierProvider<LoginNotifier, BaseState<UserCredential>>((ref) {
  return LoginNotifier(
    ref.watch(authRepositoryProvider),
    ref,
  );
});

class LoginNotifier extends BaseStateNotifier<UserCredential> {
  final AuthRepository _authRepository;

  LoginNotifier(this._authRepository, super.ref);

  Future<void> login(Map<String, dynamic> formMap) async {
    return execute(
      _authRepository.signIn(
        formMap[LoginForm.email],
        formMap[LoginForm.password],
      ),
      globalLoading: true,
      withLoadingState: true,
    );
  }
}
