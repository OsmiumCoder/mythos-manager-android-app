import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Provides an [AuthenticationRepository].
final authenticationRepositoryProvider =
    Provider<AuthenticationRepository>((ref) {
  return AuthenticationRepository(FirebaseAuth.instance);
});

/// [StreamProvider] for watching state changes of the current user.
final authenticationStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authenticationRepositoryProvider).authStateChange;
});

/// The [AuthenticationRepository] handles all CRUD operations for [User].
///
/// Author: Jonathon Meney
class AuthenticationRepository {
  /// Holds the instance of Firebase Authentication.
  final FirebaseAuth _firebaseAuth;

  /// Constructs an [AuthenticationRepository].
  AuthenticationRepository(this._firebaseAuth);

  /// Stream of auth state changes.
  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  /// Creates a new [User] from an username, email, and password.
  ///
  /// Sends request to firebase auth to create a user.
  Future<void> createUser(
      {required String username,
      required String email,
      required String password}) async {
    final response = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = response.user!;

    // Sets the users username with the provided username when being created.
    await user.updateDisplayName(username);
  }

  /// Returns the currently signed in [User].
  ///
  /// If no user is signed in null will be returned.
  User? currentUser() {
    return _firebaseAuth.currentUser;
  }

  /// Deletes and signs out a [User].
  Future<void> deleteUser(User user) {
    return user.delete();
  }
}
