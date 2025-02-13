import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/campaigns/domain/campaign.dart';
import 'package:mythos_manager/features/campaigns/domain/note.dart';

/// Provides a [CampaignRepository].
final campaignRepositoryProvider = Provider((ref) {
  return CampaignRepository(FirebaseFirestore.instance);
});

/// The [CampaignRepository] is responsible for CRUD operations on campaigns.
///
/// Author: Jonathon Meney
class CampaignRepository {
  /// Holds the instance of [FirebaseFirestore].
  final FirebaseFirestore _firestore;

  /// Constructs a [CampaignRepository].
  CampaignRepository(this._firestore);

  /// Stores a [Campaign] model in firestore database.
  Future<void> createCampaign(Campaign campaign) async {
    await _firestore
        .collection("campaigns")
        .withConverter(
            fromFirestore: Campaign.fromFirestore,
            toFirestore: (Campaign campaign, options) => campaign.toFirestore())
        // add is used to generate a unique id for each created document.
        .add(campaign);
  }

  /// Returns a list of [Campaign]'s created by the given user.
  Future<List<Campaign>> fetchCampaignsForUser(String userID) async {
    QuerySnapshot<Campaign> querySnapshot = await _firestore
        .collection("campaigns")
        .where("user_id", isEqualTo: userID)
        .withConverter(
            fromFirestore: Campaign.fromFirestore,
            toFirestore: (Campaign campaign, options) => campaign.toFirestore())
        .get();

    return querySnapshot.docs.map((document) {
      Campaign campaign = document.data();
      return campaign;
    }).toList();
  }

  /// Stores a [Note] model in firestore database.
  Future<void> createNote(Note note) async {
    await _firestore
        .collection("notes")
        .withConverter(
            fromFirestore: Note.fromFirestore,
            toFirestore: (Note note, options) => note.toFirestore())
        // add is used to generate a unique id for each created document.
        .add(note);
  }

  /// Returns a list of [Note]'s for a given campaign.
  Future<List<Note>> fetchNotesForCampaign(String campaignID) async {
    QuerySnapshot<Note> querySnapshot = await _firestore
        .collection("notes")
        .where("campaign_id", isEqualTo: campaignID)
        .withConverter(
            fromFirestore: Note.fromFirestore,
            toFirestore: (Note note, options) => note.toFirestore())
        .get();

    return querySnapshot.docs.map((document) {
      Note note = document.data();
      return note;
    }).toList();
  }
}
