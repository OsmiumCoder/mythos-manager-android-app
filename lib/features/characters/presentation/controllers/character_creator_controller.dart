import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/application/character_creator_service.dart';
import 'package:mythos_manager/features/characters/domain/character.dart';

/// Provides a [CharacterCreatorController].
final characterCreatorControllerProvider = Provider((ref) {
  return CharacterCreatorController(ref.watch(characterCreatorServiceProvider));
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
}
