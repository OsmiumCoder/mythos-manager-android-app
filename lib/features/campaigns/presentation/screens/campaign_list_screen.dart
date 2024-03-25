import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/campaigns/presentation/controllers/campaign_controller.dart';
import 'package:mythos_manager/shared/presentation/components/components.dart';

import '../../../../routing/app_router.dart';

class CampaignListScreen extends HookConsumerWidget {
  const CampaignListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Campaigns"),
          centerTitle: true,
        ),
        drawer:
            const MythosDrawer(selectedScreen: AppRouter.campaignListScreen),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                BoxShadowImage(
                  image: null, // TODO Insert Image
                  text: const Text(
                    "Create Campaign",
                    style: TextStyle(color: Colors.white),
                  ),
                  height: 150,
                  textPadding: 55,
                  onTap: () => Navigator.pushNamed(
                      context, AppRouter.campaignCreationScreen),
                ),
                ref.watch(campaignControllerProvider).when(
                    data: (campaigns) => Column(
                          children: campaigns
                              .map(
                                (campaign) => Padding(
                                  padding: const EdgeInsets.only(top: 32),
                                  child: SizedBox(
                                    width: 300,
                                    child: BoxShadowImage(
                                      image: null, // TODO Insert image
                                      text: Text(
                                        campaign.name,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      height: 75,
                                      textPadding: 22.5,
                                      onTap: () {
                                        Navigator.pushNamed(context, AppRouter.noteListScreen,arguments: campaign.uid);
                                      }, 
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                    error: (_, __) =>
                        const Text("Error occurred loading campaigns"),
                    loading: () => const CircularProgressIndicator())
              ],
            ),
          ),
        ));
  }
}
