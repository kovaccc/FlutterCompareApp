import 'package:dartz/dartz.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:fluttercompareapp/common/constants/firebase_constants.dart';
import 'package:fluttercompareapp/common/data/mappers/entity_mapper.dart';
import 'package:fluttercompareapp/common/data/mixins/error_to_failure_mixin.dart';
import 'package:fluttercompareapp/features/photos/data/datasources/local_data_sources/photos_local_data_source.dart';
import 'package:fluttercompareapp/features/photos/data/mappers/photo_entity_mapper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fluttercompareapp/features/photos/domain/entities/photo.dart';
import 'package:fluttercompareapp/common/data/api_client.dart';
import 'package:fluttercompareapp/common/data/providers.dart';
import 'package:fluttercompareapp/common/domain/either_failure_or.dart';
import 'package:fluttercompareapp/features/photos/data/database/app_database.dart'
    as db;
import 'package:loggy/loggy.dart';

final photosRepositoryProvider = Provider<PhotosRepository>((ref) {
  return PhotosRepositoryImpl(
    ref.watch(apiClientProvider),
    ref.watch(photosLocalDataSourceProvider),
    ref.watch(photoEntityMapper),
  );
});

abstract class PhotosRepository {
  EitherFailureOr<List<Photo>> refreshPhotos();
}

class PhotosRepositoryImpl
    with ErrorToFailureMixin
    implements PhotosRepository {
  final ApiClient _apiClient;
  final PhotosLocalDataSource _photosLocalDataSource;
  final EntityMapper<Photo, db.Photo> _photoMapper;

  PhotosRepositoryImpl(
    this._apiClient,
    this._photosLocalDataSource,
    this._photoMapper,
  );

  @override
  EitherFailureOr<List<Photo>> refreshPhotos() async => execute(() async {
        Trace getPhotosNetworkTrace = FirebasePerformance.instance
            .newTrace(FirebaseConstants.getPhotosFromNetworkTrace);
        await getPhotosNetworkTrace.start();
        final photoResponses = await _apiClient.getPhotos();
        await getPhotosNetworkTrace.stop();

        Trace saveToDatabaseTrace = FirebasePerformance.instance
            .newTrace(FirebaseConstants.saveToDatabaseTrace);
        await saveToDatabaseTrace.start();
        await _photosLocalDataSource.savePhotos(photoResponses);
        await saveToDatabaseTrace.stop();

        Trace readFromDatabaseTrace = FirebasePerformance.instance
            .newTrace(FirebaseConstants.readFromDatabaseTrace);
        await readFromDatabaseTrace.start();
        final localPhotos = await _photosLocalDataSource.getPhotos();
        await readFromDatabaseTrace.stop();
        final domainPhotos = localPhotos.map(_photoMapper).toList();
        return Right(domainPhotos);
      });
}
