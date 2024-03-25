import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/authentication/data/authentication_repository.dart';
import 'package:mythos_manager/features/authentication/exceptions/no_user_found_exception.dart';
import 'package:mythos_manager/features/campaigns/data/campaign_repository.dart';
import 'package:mythos_manager/features/campaigns/domain/campaign.dart';
import 'package:mythos_manager/features/campaigns/domain/note.dart';

final campaignServiceProvider = Provider((ref) {
  return CampaignService(ref.watch(campaignRepositoryProvider),
      ref.watch(authenticationRepositoryProvider));
});

/// Service for performing operations related to campaigns.
///
/// Author: Jonathon Meney
class CampaignService {
  /// The [CampaignRepository] for CRUD operations of character creation.
  final CampaignRepository _campaignRepository;

  /// The [AuthenticationRepository] for fetching the current user.
  final AuthenticationRepository _authenticationRepository;

  CampaignService(this._campaignRepository, this._authenticationRepository);

  /// Stores a [Campaign] in cloud firestore.
  ///
  /// Throws a [NoUserFoundException] if no user is signed in to attach the
  /// campaign to.
  Future<void> createCampaign(String name, String description, String characterId) async {
    User? auth = _authenticationRepository.currentUser();
    if (auth == null) {
      throw NoUserFoundException();
    }
    Campaign campaign =
        Campaign(userID: auth.uid, name: name, description: description, characterUID: characterId);
    await _campaignRepository.createCampaign(campaign);
  }

  /// Returns a list of [Campaign]'s created by the signed in user.
  ///
  /// Throws a [NoUserFoundException] if no user is signed in.
  Future<List<Campaign>> fetchCampaigns() async {
    User? auth = _authenticationRepository.currentUser();
    if (auth == null) {
      throw NoUserFoundException();
    }
    return await _campaignRepository.fetchCampaignsForUser(auth.uid);
  }

  /// Stores a [Note] in cloud firestore.
  Future<void> createNote(String campaignID, String title, String details) async {
    Note note = Note(campaignUID: campaignID, title: title, description: details);
    await _campaignRepository.createNote(note);
  }

  /// Returns a list of [Note]'s for a given campaign.
  Future<List<Note>> fetchNotesForCampaign(String campaignID) async {
    return await _campaignRepository.fetchNotesForCampaign(campaignID);
  }
}
