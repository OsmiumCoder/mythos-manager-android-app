import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mythos_manager/features/authentication/data/authentication_repository.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

/// Author: Jonathon Meney
void main() {
  MockFirebaseAuth auth = MockFirebaseAuth();
  AuthenticationRepository repo = AuthenticationRepository(auth);

  group('authentication repository tests', () {
    test('createUser creates user with valid data', () async {
      final userCredential = MockUserCredential();

      when(() => auth.createUserWithEmailAndPassword(
          email: 'valid email', password: 'password')).thenAnswer((_) async {
        return userCredential;
      });

      await repo.createUser(
          username: "username", email: "valid email", password: "password");

      verify(() => auth.createUserWithEmailAndPassword(
          email: 'valid email', password: 'password')).called(1);
    });

    test('createUser throws exception on invalid email', () async {
      when(() => auth.createUserWithEmailAndPassword(
              email: 'invalid email', password: 'password'))
          .thenThrow(FirebaseAuthException(code: "invalid-email"));

      expect(
          () async => await repo.createUser(
              username: "username",
              email: "invalid email",
              password: "password"),
          throwsA(isA<FirebaseAuthException>()));

      verify(() => auth.createUserWithEmailAndPassword(
          email: 'invalid email', password: 'password')).called(1);
    });

    test('createUser throws exception on bad password', () async {
      when(() => auth.createUserWithEmailAndPassword(
              email: 'valid email', password: 'short'))
          .thenThrow(FirebaseAuthException(code: "weak-password"));

      expect(
          () async => await repo.createUser(
              username: "username", email: "valid email", password: "short"),
          throwsA(isA<FirebaseAuthException>()));

      verify(() => auth.createUserWithEmailAndPassword(
          email: 'valid email', password: 'short')).called(1);
    });
  });
}
