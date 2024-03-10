import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Author: Liam Welsh
class AbilitySelectionRow extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
              decoration: InputDecoration(
                hintText: "6-18 Range",
                errorText: _verifyText()
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                // Allows values 1 and 6-18
                // 1 is allowed so user can enter a teen value
                FilteringTextInputFormatter.allow(RegExp(r'^1$|^[6-9]$|^1[0-8]$')),
                LengthLimitingTextInputFormatter(2),
              ]

            ),
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
