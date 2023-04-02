import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:fluttercompareapp/common/domain/notifiers/base_state.dart';
import 'package:fluttercompareapp/features/login/domain/entities/user.dart';
import 'package:fluttercompareapp/features/login/domain/notifiers/login_notifier.dart';
import 'package:state_notifier_test/state_notifier_test.dart';

//ignore: prefer-match-file-name


void main() {
  

  setUp(() {
  
  });

  ProviderContainer getProviderContainer() => ProviderContainer(overrides: [
    loginNotifierProvider.overrideWith((ref) =>
      LoginNotifier(ref)),
  ]);

  
  group(' login(email, password)', () {
  stateNotifierTest<LoginNotifier, BaseState<User>>(
    'executes success flow',
    build: () => getProviderContainer().read(loginNotifierProvider.notifier),
    setUp: () {
      // when(someRepository.method).thenAnswer(
      // (_) async => Future.value(const Right(None())),
      // );
    },
    actions: (stateNotifier) {},
    expect: () => [],
  );
  stateNotifierTest<LoginNotifier, BaseState<User>>(
    'executes failure flow',
    build: () => getProviderContainer().read(loginNotifierProvider.notifier),
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
