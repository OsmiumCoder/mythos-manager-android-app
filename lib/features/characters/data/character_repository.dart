import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/domain/character.dart';

/// Provides a [CharacterRepository].
final characterRepositoryProvider = Provider((ref) {
  return CharacterRepository(FirebaseFirestore.instance);
});

/// The [CharacterRepository] handles all CRUD operations for [Character] model.
///
/// Author: Jonathon Meney, Liam Welsh
class CharacterRepository {
  /// Holds the instance of [FirebaseFirestore].
  final FirebaseFirestore _firestore;

  /// Constructs a [CharacterRepository].
  CharacterRepository(this._firestore);

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

  /// Updates a [Character] in cloud firestore
  Future<void> updateCharacter(Character character) async {
    await _firestore
        .collection("characters")
        .doc(character.id)
        .update(character.toFirestore());
  }

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

  Future<List<Character>> fetchPublicCharacters(
      String? className, String? subclass) async {
    Query query =
        _firestore.collection("characters").where("is_public", isEqualTo: true);

    if (className != null) {
      query = query.where("class", isEqualTo: className);
    }

    if (subclass != null) {
      query = query.where("subclass", isEqualTo: subclass);
    }

    QuerySnapshot<Character> querySnapshot = await query
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

  /// Fetches a [Character] by id
  Future<Character?> fetchCharacterById(String id) async {
    DocumentSnapshot<Character> querySnapshot = await _firestore
        .collection("characters")
        .doc(id)
        .withConverter(
            fromFirestore: Character.fromFirestore,
            toFirestore: (Character character, options) =>
                character.toFirestore())
        .get();

    return querySnapshot.data();
  }
}
