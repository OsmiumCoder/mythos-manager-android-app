import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/authentication/data/authentication_repository.dart';
import 'package:mythos_manager/features/character_creator/data/character_creator_repository.dart';
import 'package:mythos_manager/features/character_creator/domain/character.dart';

/// Provides a [CharacterCreatorService].
final characterCreatorService = Provider((ref) {
  return CharacterCreatorService(ref.watch(authenticationRepositoryProvider),
      ref.watch(characterCreatorRepository));
});

/// A [NoUserFoundException] is thrown when a character is created with no auth.
class NoUserFoundException implements Exception {}

/// Service for performing operations related to character creation.
///
/// Author: Jonathon Meney
class CharacterCreatorService {
  /// The [AuthenticationRepository] for fetching the current user.
  final AuthenticationRepository _authenticationRepository;

  /// The [CharacterCreatorRepository] for CRUD operations of character creation.
  final CharacterCreatorRepository _characterCreatorRepository;

  /// Constructs a [CharacterCreatorService].
  CharacterCreatorService(
      this._authenticationRepository, this._characterCreatorRepository);

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
    await _characterCreatorRepository.createCharacter(character);
  }

// TODO: move to character service in characters/
// Future<List<Character>> fetchCharactersForUser() async {
//   User? auth = _authenticationRepository.currentUser();
//   return await _characterCreatorRepository.fetchCharactersForUser(auth!.uid);
// }
}
