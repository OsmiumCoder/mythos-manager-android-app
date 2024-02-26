import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mythos_manager/features/authentication/data/authentication_repository.dart';

void main() {
  group('authentication repository tests', () {
    setUp(() {
      AuthenticationRepository authenticationRepository = AuthenticationRepository(FirebaseAuth.instance);
    });
    
    test('auth repo creates user with valid data', () {
      print(authenticationRepositoryProvider);
    });
  });
}