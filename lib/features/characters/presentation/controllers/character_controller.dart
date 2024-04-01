import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/application/character_service.dart';
import 'package:mythos_manager/features/characters/domain/character.dart';

/// Provides a [CharacterController].
final characterControllerProvider =
    AsyncNotifierProvider<CharacterController, List<Character>>(() {
  return CharacterController();
});

/// Delegates requests related to [Character]'s.
///
/// Author: Jonathon Meney, Liam Welsh
class CharacterController extends AsyncNotifier<List<Character>> {
  /// Stores a [Character] in cloud firestore.
  Future<void> createCharacter(Character character) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() {
      ref.watch(characterServiceProvider).createCharacter(character);
      return _fetchCharacters();
    });
  }

  /// Updates a [Character] in cloud firestore.
  Future<void> updateCharacter(Character character) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() {
      ref.watch(characterServiceProvider).updateCharacter(character);
      return _fetchCharacters();
    });
  }

  /// Returns a list of the signed in users [Character]s.
  Future<List<Character>> _fetchCharacters() async {
    return ref.watch(characterServiceProvider).fetchCharacters();
  }

  /// Fetches a [Character] by id
  Future<Character?> fetchCharacterById(String id) {
    return ref.watch(characterServiceProvider).fetchCharacterById(id);
  }

  /// Returns a list of public [Character]s
  Future<List<Character>> fetchPublicCharacters(
      {String? className, String? subclass}) async {
    return ref
        .watch(characterServiceProvider)
        .fetchPublicCharacters(className, subclass);
  }

  @override
  FutureOr<List<Character>> build() {
    // Fetch characters on build.
    return _fetchCharacters();
  }
}
