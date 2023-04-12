import 'package:fluttercompareapp/common/data/mappers/entity_mapper.dart';
import 'package:fluttercompareapp/features/photos/data/database/app_database.dart'
    as db;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fluttercompareapp/features/photos/domain/entities/photo.dart';

final photoEntityMapper = Provider<EntityMapper<Photo, db.Photo>>(
  (ref) => (response) =>
      Photo(id: response.id, title: response.title, url: response.url),
);
