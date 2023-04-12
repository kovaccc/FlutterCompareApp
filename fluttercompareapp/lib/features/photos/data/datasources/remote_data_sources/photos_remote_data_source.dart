import 'package:fluttercompareapp/features/photos/data/models/photo_response.dart';

abstract class PhotosRemoteDataSource {
  Future<List<PhotoResponse>> getPhotos();
}
