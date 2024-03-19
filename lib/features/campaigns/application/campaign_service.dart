import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/authentication/data/authentication_repository.dart';
import 'package:mythos_manager/features/authentication/exceptions/no_user_found_exception.dart';
import 'package:mythos_manager/features/campaigns/data/campaign_repository.dart';
import 'package:mythos_manager/features/campaigns/domain/campaign.dart';

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
  Future<void> createCampaign(String name, String description) async {
    User? auth = _authenticationRepository.currentUser();
    if (auth == null) {
      throw NoUserFoundException();
    }
    Campaign campaign =
        Campaign(userID: auth.uid, name: name, description: description);

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
}
