import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/character_creator/application/character_creator_service.dart';
import 'package:mythos_manager/features/character_creator/domain/character.dart';

/// Provides a [CharacterCreatorController].
final characterController = Provider((ref) {
  return CharacterCreatorController(ref.watch(characterCreatorService));
});

/// Controls delegation of character creation requests.
///
/// Author: Jonathon Meney
class CharacterCreatorController {
  /// The [CharacterCreatorService] to send character data to store.
  final CharacterCreatorService _service;

  /// Constructs a [CharacterCreatorController].
  CharacterCreatorController(this._service);

  /// Stores a [Character] in cloud firestore.
  Future<void> createCharacter(Character character) async {
    await _service.createCharacter(character);
  }

// TODO: move to characters controller in characters/
// Future<List<Character>> fetchCharactersForUser() async {
//   return _service.fetchCharactersForUser();
// }
}
