import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/domain/character.dart';

/// Provides a [CharacterCreatorRepository].
final characterCreatorRepositoryProvider = Provider((ref) {
  return CharacterCreatorRepository(FirebaseFirestore.instance);
});

/// The [CharacterCreatorRepository] is responsible for storing characters.
///
/// Author: Jonathon Meney
class CharacterCreatorRepository {
  /// Holds the instance of [FirebaseFirestore].
  final FirebaseFirestore _firestore;

  /// Constructs a [CharacterCreatorRepository].
  CharacterCreatorRepository(this._firestore);

  /// Stores a [Character] in cloud firestore.
  Future<void> createCharacter(Character character) async {
    await _firestore
        .collection("characters")
        .withConverter(
            fromFirestore: Character.fromFirestore,
            toFirestore: (Character character, options) =>
                character.toFirestore())
        // add is used to generate a unique id for each created document.
        .add(character);
  }
}
