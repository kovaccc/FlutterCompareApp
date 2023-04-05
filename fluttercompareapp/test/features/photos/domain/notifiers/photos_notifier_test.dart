import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:fluttercompareapp/common/domain/notifiers/base_state.dart';
import 'package:fluttercompareapp/features/photos/domain/entities/photo.dart';
import 'package:fluttercompareapp/features/photos/domain/notifiers/photos_notifier.dart';
import 'package:state_notifier_test/state_notifier_test.dart';

//ignore: prefer-match-file-name

class MockPhotosRepository extends Mock implements PhotosRepository {} 

void main() {
  late PhotosRepository photosRepository;
  

  setUp(() {
  photosRepository = MockPhotosRepository();
  
  });

  ProviderContainer getProviderContainer() => ProviderContainer(overrides: [
    photosNotifierProvider.overrideWith((ref) =>
      PhotosNotifier(photosRepository, ref)),
  ]);

  
  group(' getPhotos()', () {
  stateNotifierTest<PhotosNotifier, BaseState<Photo>>(
    'executes success flow',
    build: () => getProviderContainer().read(photosNotifierProvider.notifier),
    setUp: () {
      // when(someRepository.method).thenAnswer(
      // (_) async => Future.value(const Right(None())),
      // );
    },
    actions: (stateNotifier) {},
    expect: () => [],
  );
  stateNotifierTest<PhotosNotifier, BaseState<Photo>>(
    'executes failure flow',
    build: () => getProviderContainer().read(photosNotifierProvider.notifier),
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
