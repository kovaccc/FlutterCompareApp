// ignore_for_file: always_use_package_imports

import 'package:dio/dio.dart';
import 'package:fluttercompareapp/features/photos/data/datasources/remote_data_sources/photos_remote_data_source.dart';
import 'package:fluttercompareapp/features/photos/data/models/photo_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../example/data/models/example_user_response.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient implements PhotosRemoteDataSource {
  factory ApiClient(Dio dio) = _ApiClient;

  @POST('/token')
  Future<ExampleUserResponse> getUser();

  @override
  @GET('/photos')
  Future<List<PhotoResponse>> getPhotos();
}
