import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authenticationRepositoryProvider =
    Provider<AuthenticationRepository>((ref) {
  return AuthenticationRepository(FirebaseAuth.instance);
});

final authenticationStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authenticationRepositoryProvider).authStateChange;
});

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;

  AuthenticationRepository(this._firebaseAuth);

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<void> createUser(
      {required String username,
      required String email,
      required String password}) async {
    final response = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = response.user!;
    await user.updateDisplayName(username);
  }

  User? currentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<void> deleteUser(User user) {
    return user.delete();
  }
}
