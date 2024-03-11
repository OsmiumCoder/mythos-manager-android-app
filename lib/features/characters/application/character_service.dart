import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/authentication/data/authentication_repository.dart';
import 'package:mythos_manager/features/authentication/exceptions/no_user_found_exception.dart';
import 'package:mythos_manager/features/character_creator/domain/character.dart';
import 'package:mythos_manager/features/characters/data/character_repository.dart';

/// Provides a [CharacterService].
final characterServiceProvider = Provider((ref) {
  return CharacterService(ref.watch(characterRepositoryProvider),
      ref.watch(authenticationRepositoryProvider));
});

/// The [CharacterService] handles operations on [Character]s.
///
/// Author: Jonathon Meney
class CharacterService {
  /// The [CharacterRepository] for CRUD operations on [Character]s.
  final CharacterRepository _characterRepository;

  /// The [AuthenticationRepository] for fetching the current user.
  final AuthenticationRepository _authenticationRepository;

  /// Constructs a [CharacterService].
  CharacterService(this._characterRepository, this._authenticationRepository);

  /// Returns a list of [Character]s created by the signed in user.
  ///
  /// Throws a [NoUserFoundException] if no user is signed in.
  Future<List<Character>> fetchCharacters() async {
    User? auth = _authenticationRepository.currentUser();
    if (auth == null) {
      throw NoUserFoundException();
    }
    return await _characterRepository.fetchCharactersForUser(auth.uid);
  }
}
