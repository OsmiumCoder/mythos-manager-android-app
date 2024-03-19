import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/application/character_service.dart';
import 'package:mythos_manager/features/characters/domain/character.dart';

/// Provides a [CharacterController].
final characterControllerProvider = AsyncNotifierProvider<CharacterController, List<Character>>((){
  return CharacterController();
});

/// Delegates requests related to [Character]s.
///
/// Author: Jonathon Meney
class CharacterController extends AsyncNotifier<List<Character>> {

  /// Returns a list of the signed in users [Character]s.
  Future<List<Character>> _fetchCharacters() async {
    return ref.watch(characterServiceProvider).fetchCharacters();
  }

  @override
  FutureOr<List<Character>> build() {
    // Fetch characters on build.
    return _fetchCharacters();
  }
}
