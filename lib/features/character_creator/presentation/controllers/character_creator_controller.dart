import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/character_creator/application/character_creator_service.dart';
import 'package:mythos_manager/features/character_creator/domain/character.dart';

final characterController = Provider((ref) {
  return CharacterCreatorController(ref.watch(characterCreatorService));
});

class CharacterCreatorController {
  final CharacterCreatorService _service;

  CharacterCreatorController(this._service);

  Future<void> createCharacter(Character character) async {
    await _service.createCharacter(character);
  }

  // TODO: move to characters controller in characters/
  // Future<List<Character>> fetchCharactersForUser() async {
  //   return _service.fetchCharactersForUser();
  // }
}
