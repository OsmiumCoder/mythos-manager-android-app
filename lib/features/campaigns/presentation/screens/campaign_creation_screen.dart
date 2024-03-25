import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/campaigns/presentation/controllers/campaign_controller.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/character_controller.dart';
import 'package:mythos_manager/routing/app_router.dart';


class CampaignCreationScreen extends HookConsumerWidget {
  const CampaignCreationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final characterController = useTextEditingController();
    final selectedCharacter = useState<String?>(null);

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
                decoration: const InputDecoration(
                    filled: true,
                    hintText: "Campaign Name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              child: TextField(
                controller: descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: "Campaign Details",
                ),
              ),
            ),
            ref.watch(characterControllerProvider).when(
                  data: (characters) => Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 50),
                    child: DropdownMenu(
                        controller: characterController,
                        width: 300,
                        hintText: "Starting Character",
                        onSelected: (value) => selectedCharacter.value = value,
                        dropdownMenuEntries: characters
                            .map((character) => DropdownMenuEntry(
                                  value: character.id,
                                  label: character.name ??
                                      "Character #${characters.indexOf(character) + 1}",
                                ))
                            .toList()),
                  ),
                  error: (_, __) =>
                      const Text("An error occurred loading your characters"),
                  loading: () => const CircularProgressIndicator(),
                ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: ElevatedButton(
                onPressed: nameController.text.isNotEmpty &&
                        descriptionController.text.isNotEmpty &&
                        selectedCharacter.value != null
                    ? () {
                        ref
                            .read(campaignControllerProvider.notifier)
                            .createCampaign(
                                nameController.text,
                                descriptionController.text,
                                selectedCharacter.value!);
                        Navigator.pushReplacementNamed(
                            context, AppRouter.campaignListScreen);
                      }
                    : null,
                child: const Text("Create"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
