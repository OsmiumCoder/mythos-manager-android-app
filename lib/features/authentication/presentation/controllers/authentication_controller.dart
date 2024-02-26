import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/authentication/application/authentication_service.dart';
import 'package:mythos_manager/features/authentication/data/authentication_repository.dart';

final authenticationControllerProvider = Provider<AuthenticationController>((ref) {
  return AuthenticationController(ref.watch(authenticationServiceProvider));
});

class AuthenticationController {

  final AuthenticationService _authenticationService;

  AuthenticationController(this._authenticationService);

  Future signup({required String username, required String email, required String password}) {
    return _authenticationService.signUp(username: username, email: email, password: password);
  }


}