
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/authentication/data/authentication_repository.dart';

final authenticationServiceProvider = Provider<AuthenticationService>((ref) {
  return AuthenticationService(ref.watch(authenticationRepositoryProvider));
});

class AuthenticationService {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationService(this._authenticationRepository);

  Future signUp({required String username, required String email, required String password}) {
    return _authenticationRepository.createUser(username: username, email: email, password: password);
  }
}