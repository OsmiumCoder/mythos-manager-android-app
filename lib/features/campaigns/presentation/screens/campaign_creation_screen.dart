import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/campaigns/presentation/controllers/campaign_controller.dart';

class CampaignCreationScreen extends HookConsumerWidget {
  const CampaignCreationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final characterController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Campaign"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 25, bottom: 15, left: 50, right: 50),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                    fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                    filled: true,
                    hintText: "Campaign Name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              child: TextField(
                controller: descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                  filled: true,
                  hintText: "Campaign Details",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              child: DropdownMenu(
                  controller: characterController,
                  width: 300,
                  hintText: "Starting Character",
                  dropdownMenuEntries: const [] // TODO Fetch characters and display entries,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: ElevatedButton(
                child: const Text("Create"),
                onPressed: () {
                  ref.read(campaignControllerProvider.notifier).createCampaign(
                      nameController.text, descriptionController.text);
                  // TODO Route user to campaign list screen
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
