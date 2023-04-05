import 'package:dartz/dartz.dart';
import 'package:fluttercompareapp/common/data/mappers/entity_mapper.dart';
import 'package:fluttercompareapp/common/data/mixins/error_to_failure_mixin.dart';
import 'package:fluttercompareapp/features/photos/data/mappers/photo_entity_mapper.dart';
import 'package:fluttercompareapp/features/photos/data/models/photo_response.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:fluttercompareapp/features/photos/domain/entities/photo.dart';

import 'package:fluttercompareapp/common/data/api_client.dart';
import 'package:fluttercompareapp/common/data/providers.dart';
import 'package:fluttercompareapp/common/domain/either_failure_or.dart';

final photosRepositoryProvider = Provider<PhotosRepository>((ref) {
  return PhotosRepositoryImpl(
    ref.watch(apiClientProvider),
    ref.watch(photoEntityMapper),
  );
});

abstract class PhotosRepository {
  EitherFailureOr<List<Photo>> getPhotos();
}

class PhotosRepositoryImpl
    with ErrorToFailureMixin
    implements PhotosRepository {
  final ApiClient _apiClient;
  final EntityMapper<Photo, PhotoResponse> _photoMapper;

  PhotosRepositoryImpl(
    this._apiClient,
    this._photoMapper,
  );

  @override
  EitherFailureOr<List<Photo>> getPhotos() async => execute(() async {
        final result = await _apiClient.getPhotos();
        final photos = result.map(_photoMapper).toList();
        return Right(photos);
      });
}
