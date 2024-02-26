import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authenticationRepositoryProvider = Provider<AuthenticationRepository>((ref) {
  return AuthenticationRepository(FirebaseAuth.instance);
});

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;

  AuthenticationRepository(this._firebaseAuth);

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<User> createUser(
      {required String username,
      required String email,
      required String password}) async {
    try {
      final response = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = response.user!;
      await user.updateDisplayName(username);
      return user;
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  User? currentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<void> deleteUser(User user) {
    return user.delete();
  }

  Future<User?> signIn(
      {required String email, required String password}) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = response.user;
      return user;
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  Future<void> signOut(User user) {
    return _firebaseAuth.signOut();
  }
}
