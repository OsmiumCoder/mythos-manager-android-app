import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RaceSelectionScreen extends HookConsumerWidget {
  const RaceSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character Creator'),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Center(child: Text("Choose a Race", style: TextStyle(fontSize: 15),)),
            ],
          ),
        ),
      ),
    );
  }
}
