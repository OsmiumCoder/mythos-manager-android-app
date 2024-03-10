import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/character_creator/domain/character.dart';

final characterCreatorRepository = Provider((ref) {
  return CharacterCreatorRepository(FirebaseFirestore.instance);
});

class CharacterCreatorRepository {
  final FirebaseFirestore _firestore;

  CharacterCreatorRepository(this._firestore);

  Future<void> createCharacter(Character character) async {
    await _firestore
        .collection("characters")
        .withConverter(
            fromFirestore: Character.fromFirestore,
            toFirestore: (Character character, options) =>
                character.toFirestore())
        .add(character);
  }

// TODO: move to characters repo in characters/
// Future<List<Character>> fetchCharactersForUser(String userID) async {
//   QuerySnapshot<Character> querySnapshot = await _firestore
//       .collection("characters")
//       .where("user_id", isEqualTo: userID)
//       .withConverter(
//           fromFirestore: Character.fromFirestore,
//           toFirestore: (Character character, options) =>
//               character.toFirestore())
//       .get();
//
//   return querySnapshot.docs.map((document) {
//     Character character = document.data();
//     return character;
//   }).toList();
// }
}
