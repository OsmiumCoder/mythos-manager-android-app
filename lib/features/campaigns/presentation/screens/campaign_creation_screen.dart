import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CampaignCreationScreen extends StatelessWidget {
  const CampaignCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final detailsController = useTextEditingController();
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
                decoration: const InputDecoration(hintText: "Campaign Name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              child: TextField(
                controller: detailsController,
                decoration: const InputDecoration(
                    hintText: "Campaign Details",
                    contentPadding:
                        EdgeInsets.only(top: 50, bottom: 50, left: 15)),
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
                  print(nameController.text);
                  print(detailsController.text);
                  print(characterController.text);
                  // TODO Handle navigation
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
