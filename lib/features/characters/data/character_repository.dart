import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/domain/character.dart';

/// Provides a [CharacterRepository].
final characterRepositoryProvider = Provider((ref) {
  return CharacterRepository(FirebaseFirestore.instance);
});

/// The [CharacterRepository] handles all CRUD operations for [Character] model.
///
/// Author: Jonathon Meney
class CharacterRepository {
  /// Holds the instance of [FirebaseFirestore].
  final FirebaseFirestore _firestore;

  /// Constructs a [CharacterRepository].
  CharacterRepository(this._firestore);

  /// Returns a list of [Character]s created by the given user.
  Future<List<Character>> fetchCharactersForUser(String userID) async {
    QuerySnapshot<Character> querySnapshot = await _firestore
        .collection("characters")
        .where("user_id", isEqualTo: userID)
        .withConverter(
            fromFirestore: Character.fromFirestore,
            toFirestore: (Character character, options) =>
                character.toFirestore())
        .get();

    return querySnapshot.docs.map((document) {
      Character character = document.data();
      return character;
    }).toList();
  }
}
