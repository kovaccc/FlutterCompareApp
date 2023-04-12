import 'package:fluttercompareapp/common/data/mappers/entity_mapper.dart';
import 'package:fluttercompareapp/features/photos/data/database/app_database.dart';
import 'package:fluttercompareapp/features/photos/data/models/photo_response.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final photoDatabaseMapper =
    Provider<EntityMapper<PhotosCompanion, PhotoResponse>>(
  (ref) => (response) => PhotosCompanion.insert(
        id: response.id,
        title: response.title,
        url: response.url,
      ),
);
