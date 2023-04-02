import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:fluttercompareapp/common/data/repositories/auth_repository.dart';
import 'package:fluttercompareapp/common/data/api_client.dart';


//ignore: prefer-match-file-name

class MockApiClient extends Mock implements ApiClient {} 

void main() {
  late ApiClient apiClient;
  
  late AuthRepository authRepository;
  setUp(() {
    apiClient = MockApiClient();
    
    authRepository = AuthRepositoryImpl(apiClient, );
  });

    
    
    group(' login(String email, String password)', () {
      test('executes success flow', () async {
        // final value = authRepository. login(String email, String password);
        //expect(value, equals(smth));
      });

      test('executes failure flow', () async {
        // final value = authRepository. login(String email, String password);
        //expect(value, equals(smth));
      });
    });
    

}
