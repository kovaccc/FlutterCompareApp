import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:fluttercompareapp/common/domain/notifiers/base_state.dart';
import 'package:fluttercompareapp/features/register/domain/entities/user_credential.dart';
import 'package:fluttercompareapp/features/register/domain/notifiers/register_notifier.dart';
import 'package:state_notifier_test/state_notifier_test.dart';

//ignore: prefer-match-file-name

class MockAuthRepository extends Mock implements AuthRepository {} 

void main() {
  late AuthRepository authRepository;
  

  setUp(() {
  authRepository = MockAuthRepository();
  
  });

  ProviderContainer getProviderContainer() => ProviderContainer(overrides: [
    registerNotifierProvider.overrideWith((ref) =>
      RegisterNotifier(authRepository, ref)),
  ]);

  
  group(' register(String email, String password)', () {
  stateNotifierTest<RegisterNotifier, BaseState<UserCredential>>(
    'executes success flow',
    build: () => getProviderContainer().read(registerNotifierProvider.notifier),
    setUp: () {
      // when(someRepository.method).thenAnswer(
      // (_) async => Future.value(const Right(None())),
      // );
    },
    actions: (stateNotifier) {},
    expect: () => [],
  );
  stateNotifierTest<RegisterNotifier, BaseState<UserCredential>>(
    'executes failure flow',
    build: () => getProviderContainer().read(registerNotifierProvider.notifier),
    setUp: () {
      // when(someRepository.method).thenAnswer(
      // (_) async => Future.value(const Right(None())),
      // );
    },
    actions: (stateNotifier) {},
    expect: () => [],
  );
  });
  
}
