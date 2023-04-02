import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttercompareapp/features/auth/login/data/repositories/auth_repository.dart';
import 'package:fluttercompareapp/features/auth/register/forms/register_form.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:fluttercompareapp/common/domain/notifiers/base_state_notifier.dart';
import 'package:fluttercompareapp/common/domain/notifiers/base_state.dart';

final registerNotifierProvider =
    StateNotifierProvider<RegisterNotifier, BaseState<UserCredential>>((ref) {
  return RegisterNotifier(
    ref.watch(authRepositoryProvider),
    ref,
  );
});

class RegisterNotifier extends BaseStateNotifier<UserCredential> {
  final AuthRepository _authRepository;

  RegisterNotifier(this._authRepository, super.ref);

  Future<Future> register(Map<String, dynamic> formMap) async {
    return execute(
      _authRepository.register(
        formMap[RegisterForm.email],
        formMap[RegisterForm.password],
      ),
      globalLoading: true,
      withLoadingState: true,
    );
  }
}
