import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/authentication/data/authentication_repository.dart';

final authenticationServiceProvider = Provider<AuthenticationService>((ref) {
  return AuthenticationService(
      FirebaseAuth.instance, ref.watch(authenticationRepositoryProvider));
});

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final AuthenticationRepository _authenticationRepository;

  AuthenticationService(this._firebaseAuth, this._authenticationRepository);

  Future<void> signUp(
      {required String username,
      required String email,
      required String password}) async {
    await _authenticationRepository.createUser(
        username: username, email: email, password: password);
  }

  Future<void> signUpAndLogin(
      {required String username,
      required String email,
      required String password}) async {
    await signUp(username: username, email: email, password: password);
    await login(email: email, password: password);
  }

  Future<void> login({required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
