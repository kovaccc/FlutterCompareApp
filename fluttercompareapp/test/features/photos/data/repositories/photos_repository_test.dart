import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:fluttercompareapp/features/photos/data/repositories/photos_repository.dart';
import 'package:fluttercompareapp/common/data/api_client.dart';


//ignore: prefer-match-file-name

class MockApiClient extends Mock implements ApiClient {} 

void main() {
  late ApiClient apiClient;
  
  late PhotosRepository photosRepository;
  setUp(() {
    apiClient = MockApiClient();
    
    photosRepository = PhotosRepositoryImpl(apiClient, );
  });

    
    
    group(' getPhotos()', () {
      test('executes success flow', () async {
        // final value = photosRepository. getPhotos();
        //expect(value, equals(smth));
      });

      test('executes failure flow', () async {
        // final value = photosRepository. getPhotos();
        //expect(value, equals(smth));
      });
    });
    

}
