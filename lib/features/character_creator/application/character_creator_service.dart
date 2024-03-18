import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/authentication/data/authentication_repository.dart';
import 'package:mythos_manager/features/authentication/exceptions/no_user_found_exception.dart';
import 'package:mythos_manager/features/character_creator/data/character_creator_repository.dart';
import 'package:mythos_manager/features/character_creator/domain/character.dart';

/// Provides a [CharacterCreatorService].
final characterCreatorServiceProvider = Provider((ref) {
  return CharacterCreatorService(ref.watch(characterCreatorRepositoryProvider),
      ref.watch(authenticationRepositoryProvider));
});

/// Service for performing operations related to character creation.
///
/// Author: Jonathon Meney
class CharacterCreatorService {
  /// The [CharacterCreatorRepository] for CRUD operations of character creation.
  final CharacterCreatorRepository _characterCreatorRepository;

  /// The [AuthenticationRepository] for fetching the current user.
  final AuthenticationRepository _authenticationRepository;

  /// Constructs a [CharacterCreatorService].
  CharacterCreatorService(
    this._characterCreatorRepository,
    this._authenticationRepository,
  );

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
}
