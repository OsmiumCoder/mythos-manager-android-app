import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/campaigns/domain/campaign.dart';
import 'package:mythos_manager/features/campaigns/presentation/controllers/campaign_controller.dart';
import 'package:mythos_manager/routing/app_router.dart';
import 'package:mythos_manager/shared/presentation/components/components.dart';

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
                  image: const Image(
                    image: Svg("assets/images/campaign_button_image.svg"),
                  ),
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
                    data: (List<Campaign> campaigns) => Column(
                          children: campaigns
                              .map(
                                (Campaign campaign) => Padding(
                                  padding: const EdgeInsets.only(top: 32),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, AppRouter.noteListScreen,
                                          arguments: campaign);
                                    },
                                    child: Card(
                                      child: SizedBox(
                                        height: 100,
                                        width: 300,
                                        child: Center(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              campaign.name,
                                              style: const TextStyle(color: Colors.white, fontSize: 25),
                                            ),
                                          ),
                                        ),

                                      ),
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
