import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/authentication/data/user_repository.dart';

final authenticationControllerProvider = Provider((ref) {
  return AuthenticationController(ref.watch(userRepositoryProvider));
});

class AuthenticationController {

  final UserRepository _userRepository;

  AuthenticationController(this._userRepository);
}