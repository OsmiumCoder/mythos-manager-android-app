import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mythos_manager/features/character_creator/domain/character.dart';

/// The [Campaign] model holds basic information for a campaign.
///
/// Author: Jonathon Meney
class Campaign {
  /// The firestore document id.
  final String? uid;

  /// The id of the user who owns the character.
  final String userID;

  /// The [name] of the campaign.
  final String name;

  /// A short description of the campaign.
  final String description;

  /// The [Character] document id for the linked character.
  ///
  /// If no character is linked [characterUID] will be null.
  final String? characterUID;

  /// Constructs a [Campaign] model.
  Campaign(
      {this.uid,
      required this.userID,
      required this.name,
      required this.description,
      this.characterUID});

  /// Constructs a [Campaign] from a firestore data [snapshot].
  factory Campaign.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Campaign(
        uid: data?["id"],
        userID: data?["user_id"],
        name: data?["name"],
        description: data?["description"],
        characterUID: data?["character_id"]);
  }

  /// Returns a map of a [Campaign]'s attributes to store in Firestore.
  Map<String, dynamic> toFirestore() {
    return {
      "user_id": userID,
      "name": name,
      "description": description,
      if (characterUID != null) "character_id": characterUID
    };
  }
}
