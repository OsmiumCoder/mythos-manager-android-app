import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mythos_manager/features/authentication/application/authentication_service.dart';
import 'package:mythos_manager/features/authentication/data/authentication_repository.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

/// Author: Jonathon Meney
void main() {
  MockFirebaseAuth auth = MockFirebaseAuth();
  AuthenticationRepository repo = AuthenticationRepository(auth);
  AuthenticationService service = AuthenticationService(auth, repo);

  group('authentication service tests', () {
    test('signUp creates user with valid data', () async {
      final userCredential = MockUserCredential();

      when(() => auth.createUserWithEmailAndPassword(
          email: 'valid email', password: 'password')).thenAnswer((_) async {
        return userCredential;
      });

      await service.signUp(
          username: "username", email: "valid email", password: "password");

      verify(() => auth.createUserWithEmailAndPassword(
          email: 'valid email', password: 'password')).called(1);
    });

    test('signUpAndLogin creates user with valid data and logins in user',
        () async {
      final userCredential = MockUserCredential();

      when(() => auth.createUserWithEmailAndPassword(
          email: 'valid email', password: 'password')).thenAnswer((_) async {
        return userCredential;
      });

      when(() => auth.signInWithEmailAndPassword(
          email: 'valid email', password: 'password')).thenAnswer((_) async {
        return userCredential;
      });

      await service.signUpAndLogin(
          username: "username", email: "valid email", password: "password");

      verify(() => auth.createUserWithEmailAndPassword(
          email: 'valid email', password: 'password')).called(1);
      verify(() => auth.signInWithEmailAndPassword(
          email: 'valid email', password: 'password')).called(1);
    });

    test('login logins in user', () async {
      final userCredential = MockUserCredential();

      when(() => auth.signInWithEmailAndPassword(
          email: 'valid email', password: 'password')).thenAnswer((_) async {
        return userCredential;
      });

      await service.login(email: "valid email", password: "password");

      verify(() => auth.signInWithEmailAndPassword(
          email: 'valid email', password: 'password')).called(1);
    });

    test('signOut signs out the user', () async {
      when(() => auth.signOut()).thenAnswer((_) async {});

      await service.signOut();

      verify(() => auth.signOut()).called(1);
    });
  });
}
