import 'package:fluttercompareapp/common/data/mappers/entity_mapper.dart';
import 'package:fluttercompareapp/features/photos/data/models/photo_response.dart';
import 'package:fluttercompareapp/features/photos/domain/entities/photo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final photoEntityMapper = Provider<EntityMapper<Photo, PhotoResponse>>(
  (ref) => (response) =>
      Photo(id: response.id, title: response.title, url: response.url),
);
