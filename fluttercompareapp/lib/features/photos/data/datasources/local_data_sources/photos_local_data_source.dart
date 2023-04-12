import 'package:fluttercompareapp/common/data/mappers/entity_mapper.dart';
import 'package:fluttercompareapp/features/photos/data/database/app_database.dart';
import 'package:fluttercompareapp/features/photos/data/mappers/photo_database_mapper.dart';
import 'package:fluttercompareapp/features/photos/data/models/photo_response.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final photosLocalDataSourceProvider = Provider<PhotosLocalDataSource>((ref) {
  return PhotosLocalDataSource(
    ref.watch(databaseProvider),
    ref.watch(photoDatabaseMapper),
  );
});

class PhotosLocalDataSource {
  final AppDatabase _appDatabase;
  final EntityMapper<PhotosCompanion, PhotoResponse> _photoDatabaseMapper;

  PhotosLocalDataSource(
    this._appDatabase,
    this._photoDatabaseMapper,
  );

  Future<void> savePhotos(List<PhotoResponse> photos) async {
    for (var photo in photos) {
      await _appDatabase
          .into(_appDatabase.photos)
          .insert(_photoDatabaseMapper(photo));
    }
  }

  Future<List<Photo>> getPhotos() async {
    return await _appDatabase.select(_appDatabase.photos).get();
  }
}
