import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:fluttercompareapp/features/photos/data/repositories/photos_repository.dart';

import 'package:fluttercompareapp/common/domain/notifiers/base_state_notifier.dart';
import 'package:fluttercompareapp/common/domain/notifiers/base_state.dart';
import 'package:fluttercompareapp/features/photos/domain/entities/photo.dart';

final photosNotifierProvider =
    StateNotifierProvider<PhotosNotifier, BaseState<List<Photo>>>((ref) {
  return PhotosNotifier(
    ref.watch(photosRepositoryProvider),
    ref,
  )..getPhotos();
});

class PhotosNotifier extends BaseStateNotifier<List<Photo>> {
  final PhotosRepository _photosRepository;

  PhotosNotifier(this._photosRepository, super.ref);

  void getPhotos() => execute(
        _photosRepository.refreshPhotos(),
      );
}
