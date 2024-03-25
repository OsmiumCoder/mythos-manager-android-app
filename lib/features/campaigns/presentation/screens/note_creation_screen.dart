import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/campaigns/presentation/controllers/campaign_controller.dart';
import 'package:mythos_manager/features/campaigns/presentation/controllers/note_controller.dart';

import '../../../../routing/app_router.dart';
/// Author: Shreif Abdalla
class NoteCreationScreen extends HookConsumerWidget {
  const NoteCreationScreen(this.campaignID, {super.key});

  final String campaignID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Note"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 25, bottom: 15, left: 50, right: 50),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                    fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                    filled: true,
                    hintText: "Note Title"),
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
                  hintText: "Note Details",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: ElevatedButton(
                child: const Text("Create"),
                onPressed: () {
                  ref
                      .read(noteControllerProvider(campaignID).notifier)
                      .createNote(campaignID, titleController.text,
                          descriptionController.text);
                  Navigator.pushReplacementNamed(
                      context, AppRouter.noteListScreen,arguments: campaignID);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
