import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/character_builder_controller.dart';

/// Author: Liam Welsh
class AbilitySelectionRow extends HookConsumerWidget {
  final TextEditingController controller;
  final int bonus;
  final String type;

  const AbilitySelectionRow(
      {super.key,
      required this.controller,
      required this.bonus,
      required this.type});

  _verifyText() {
    if (controller.text.isNotEmpty && int.parse(controller.text) < 6) {
      return "$type must be at least 6";
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characterBuilder = ref.watch(characterBuilderProvider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              type,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 250,
            child: TextField(
                controller: controller,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    characterBuilder.state.selectedAbilityScoreIncreases[type] =
                        int.parse(value);
                  }
                },
                decoration: InputDecoration(
                    hintText: "6-18 Range", errorText: _verifyText()),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  // Allows values 1 and 6-18
                  // 1 is allowed so user can enter a teen value
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^1$|^[6-9]$|^1[0-8]$')),
                  LengthLimitingTextInputFormatter(2),
                ]),
          ),
          const Spacer(),
          Expanded(
            child: Text(
              controller.text.isEmpty
                  ? "$bonus"
                  : "${int.parse(controller.text) + bonus}",
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
