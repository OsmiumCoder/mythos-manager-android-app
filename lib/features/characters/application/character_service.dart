import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/authentication/data/authentication_repository.dart';
import 'package:mythos_manager/features/authentication/exceptions/no_user_found_exception.dart';
import 'package:mythos_manager/features/characters/data/character_repository.dart';
import 'package:mythos_manager/features/characters/domain/character.dart';

/// Provides a [CharacterService].
final characterServiceProvider = Provider((ref) {
  return CharacterService(ref.watch(characterRepositoryProvider),
      ref.watch(authenticationRepositoryProvider));
});

/// The [CharacterService] handles operations on [Character]s.
///
/// Author: Jonathon Meney, Liam Welsh
class CharacterService {
  /// The [CharacterRepository] for CRUD operations on [Character]s.
  final CharacterRepository _characterRepository;

  /// The [AuthenticationRepository] for fetching the current user.
  final AuthenticationRepository _authenticationRepository;

  /// Constructs a [CharacterService].
  CharacterService(this._characterRepository, this._authenticationRepository);

  /// Stores a [Character] in cloud firestore.
  ///
  /// Throws a [NoUserFoundException] if no user is signed in to attach the
  /// character to.
  Future<void> createCharacter(Character character) async {
    User? auth = _authenticationRepository.currentUser();
    if (auth == null) {
      throw NoUserFoundException();
    }
    character.userID = auth.uid;
    await _characterRepository.createCharacter(character);
  }

  /// Updates a [Character] in cloud firestore.
  ///
  /// Throws a [NoUserFoundException] if no user is signed in
  Future<void> updateCharacter(Character character) async {
    User? auth = _authenticationRepository.currentUser();
    if (auth == null) {
      throw NoUserFoundException();
    }
    await _characterRepository.updateCharacter(character);
  }

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

  /// Returns a list of public [Character]s
  ///
  /// Throws a [NoUserFoundException] if no user is signed in
  Future<List<Character>> fetchPublicCharacters(
      String? className, String? subclass) async {
    User? auth = _authenticationRepository.currentUser();
    if (auth == null) {
      throw NoUserFoundException();
    }
    return await _characterRepository.fetchPublicCharacters(
        className, subclass);
  }

  /// Fetches a [Character] by id
  Future<Character?> fetchCharacterById(String id) {
    return _characterRepository.fetchCharacterById(id);
  }
}
