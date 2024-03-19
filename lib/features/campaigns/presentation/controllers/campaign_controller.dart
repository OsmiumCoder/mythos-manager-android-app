import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/campaigns/application/campaign_service.dart';
import 'package:mythos_manager/features/campaigns/domain/campaign.dart';

/// Provides a [CampaignController].
final campaignControllerProvider = AsyncNotifierProvider<CampaignController, List<Campaign>>(() {
  return CampaignController();
});

/// Delegates requests related to [Campaign]'s.
///
/// Author: Jonathon Meney
class CampaignController extends AsyncNotifier<List<Campaign>> {
  /// Creates a new [Campaign].
  Future<void> createCampaign(String name, String description) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      ref.watch(campaignServiceProvider).createCampaign(name, description);
      return _fetchCampaigns();
    });
  }

  /// Returns a list of the signed in users [Campaign]'s.
  Future<List<Campaign>> _fetchCampaigns() async {
    return ref.watch(campaignServiceProvider).fetchCampaigns();
  }

  @override
  FutureOr<List<Campaign>> build() {
    return _fetchCampaigns();
  }
}
