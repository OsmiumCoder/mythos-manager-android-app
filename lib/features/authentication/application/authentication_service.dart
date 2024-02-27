import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/authentication/data/authentication_repository.dart';

final authenticationServiceProvider = Provider<AuthenticationService>((ref) {
  return AuthenticationService(FirebaseAuth.instance, ref.watch(authenticationRepositoryProvider));
});

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final AuthenticationRepository _authenticationRepository;

  AuthenticationService(this._firebaseAuth, this._authenticationRepository);

  Future<User> signUp({required String username, required String email, required String password}) async {
    return await _authenticationRepository.createUser(username: username, email: email, password: password);
  }

  Future<User> signIn(
      {required String email, required String password}) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = response.user!;
      return user;
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  Future<void> signOut(User user) async {
    return await _firebaseAuth.signOut();
  }
}