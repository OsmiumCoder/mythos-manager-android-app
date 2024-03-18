import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mythos_manager/features/campaigns/domain/campaign.dart';

/// The [Note] model tracks a notes title and description.
///
/// Author: Jonathon Meney
class Note {
  /// The [Campaign] id the note belongs.
  final String campaignUID;

  /// The [title] of the note.
  final String title;

  /// The [description] of the note.
  final String description;

  /// Constructs a [Note] model.
  Note(
      {required this.campaignUID,
      required this.title,
      required this.description});

  /// Constructs a [Note] from a firestore data [snapshot].
  factory Note.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Note(
        campaignUID: data?["campaign_id"],
        title: data?["title"],
        description: data?["description"]);
  }

  /// Returns a map of a [Note]'s attributes to store in Firestore.
  Map<String, dynamic> toFirestore() {
    return {
      "campaign_id": campaignUID,
      "title": title,
      "description": description,
    };
  }
}
