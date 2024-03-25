import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/campaigns/domain/campaign.dart';
import 'package:mythos_manager/features/campaigns/domain/note.dart';
import 'package:mythos_manager/features/campaigns/presentation/controllers/note_controller.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/character_controller.dart';
import 'package:mythos_manager/routing/app_router.dart';

/// Author: Shreif Abdalla
class NoteListScreen extends HookConsumerWidget {
  const NoteListScreen(this.campaign, {super.key});

  final Campaign campaign;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, AppRouter.noteCreationScreen,
                          arguments: campaign.uid),
                      child: const Card(
                        child: SizedBox(
                          height: 150,
                          child: Center(
                            child: Text(
                              "New Note",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: ref
                          .watch(characterControllerProvider.notifier)
                          .fetchCharacterById(campaign.characterUID ?? ""),
                      builder: (context, snapshot) => GestureDetector(
                        onTap: snapshot.hasData && snapshot.data != null
                            ? () => Navigator.pushNamed(
                                context, AppRouter.characterDisplayScreen,
                                arguments: snapshot.data!)
                            : null,
                        child: Card(
                          child: Container(
                            height: 150,
                            alignment: Alignment.center,
                            child: const Center(
                              child: Text(
                                "Campaign Character",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Following is your existing code for notes display
              ref.watch(noteControllerProvider(campaign.uid!)).when(
                    data: (List<Note> notes) => Column(
                      children: notes.map((Note note) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: ListTile(
                                title: Text(
                                  note.title,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                subtitle: Text(
                                  note.description,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ));
                      }).toList(),
                    ),
                    error: (_, __) =>
                        const Text("Error occurred loading notes"),
                    loading: () => const CircularProgressIndicator(),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
