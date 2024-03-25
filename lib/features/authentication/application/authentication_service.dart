import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/authentication/data/authentication_repository.dart';


/// Provides an [AuthenticationService].
final authenticationServiceProvider = Provider<AuthenticationService>((ref) {
  return AuthenticationService(
      FirebaseAuth.instance, ref.watch(authenticationRepositoryProvider));
});

/// Service for performing operations related to authentication.
///
/// Author: Jonathon Meney
class AuthenticationService {
  /// The instance of Firebase Authentication.
  final FirebaseAuth _firebaseAuth;

  /// The [AuthenticationRepository] used for performing data operations.
  final AuthenticationRepository _authenticationRepository;

  /// Constructs an [AuthenticationService].
  AuthenticationService(this._firebaseAuth, this._authenticationRepository);

  /// Signs up a new user with the given username, email, and password.
  Future<void> signUp(
      {required String username,
      required String email,
      required String password}) async {
    await _authenticationRepository.createUser(
        username: username, email: email, password: password);
  }

  /// Signs up a new user with the given username, email, and password.
  ///
  /// After a user as been created they will also be logged in.
  Future<void> signUpAndLogin(
      {required String username,
      required String email,
      required String password}) async {
    await signUp(username: username, email: email, password: password);
    await login(email: email, password: password);
  }


  /// Attempts to login a user with the given email and password.
  Future<void> login({required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  /// Signs out the currently signed in user.
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  /// Returns the currently signed in [User].
  ///
  /// If no user is signed in null will be returned.
  User? currentUser() {
    return _authenticationRepository.currentUser();
  }

}
