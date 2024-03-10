import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/authentication/data/authentication_repository.dart';
import 'package:mythos_manager/features/character_creator/data/character_creator_repository.dart';
import 'package:mythos_manager/features/character_creator/domain/character.dart';

final characterCreatorService = Provider((ref) {
  return CharacterCreatorService(ref.watch(authenticationRepositoryProvider),
      ref.watch(characterCreatorRepository));
});

class NoUserFoundException implements Exception {}

class CharacterCreatorService {
  final AuthenticationRepository _authenticationRepository;
  final CharacterCreatorRepository _characterCreatorRepository;

  CharacterCreatorService(
      this._authenticationRepository, this._characterCreatorRepository);

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
