import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/character_creator/presentation/controllers/dnd_api_controller.dart';
import 'package:mythos_manager/features/character_creator/presentation/screens/components/class_selection/subclass_future_builder.dart';
import 'package:mythos_manager/features/character_creator/presentation/screens/components/components.dart';

class ClassFutureBuilder extends HookConsumerWidget {
  const ClassFutureBuilder({
    Key? key,
    required this.classController,
    required this.textStyle,
    required this.subclassController,
    required this.hitDieController,
    required this.proficiencyController,
    required this.savingThrowsController,
    required this.startingEquipmentController,
  }) : super(key: key);

  final TextEditingController classController;
  final TextStyle textStyle;
  final TextEditingController subclassController;
  final TextEditingController hitDieController;
  final TextEditingController proficiencyController;
  final TextEditingController savingThrowsController;
  final TextEditingController startingEquipmentController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedProficiency1 = useState<String?>(null);
    final selectedProficiency2 = useState<String?>(null);
    final selectedEquipment1 = useState<String?>(null);
    final selectedEquipment2 = useState<String?>(null);


    return FutureBuilder(
      future: ref.watch(dndApiController).getClass(classController.text.toLowerCase()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return const Text('No data available');
        }

        final gameClass = snapshot.data!;
        final String hitDie = "Hit Die: ${gameClass["hit_die"]}";

        final List<dynamic> proficiencyData = gameClass["proficiencies"] ?? [];
        final String proficiencies = proficiencyData.map((element) => element["name"]).join(", ");

        final List<dynamic> savingThrowsData = gameClass["saving_throws"] ?? [];
        final String savingThrows = savingThrowsData.map((element) => element["name"]).join(", ");

        final List<dynamic> proficiencyOptions = gameClass["proficiency_choices"]?.first["from"]["options"] ?? [];
        final List<DropdownMenuItem<String>> proficiencyItems1 = [];
        final List<DropdownMenuItem<String>> proficiencyItems2 = [];

        final String startingEquipment = (gameClass["starting_equipment"] as List<dynamic>?)
            ?.where((element) => element != null && element["equipment"] != null && element["equipment"]["name"] != null)
            .map((element) => element["equipment"]["name"].toString())
            .join(", ") ?? "Not available";

        final List<dynamic>? startingEquipmentOptionsRaw = gameClass["starting_equipment_options"]?.first["from"]["options"] as List<dynamic>?;
        final List<DropdownMenuItem<String>> equipmentItems1 = [];
        final List<DropdownMenuItem<String>> equipmentItems2 = [];

        // Safe iteration and item creation, considering null and structure checks.
        startingEquipmentOptionsRaw?.forEach((optionGroup) {
          final List<dynamic>? options = optionGroup["equipment"] as List<dynamic>?;
          options?.forEach((option) {
            final String? name = option["name"];
            if (name != null && name != selectedEquipment2.value && !equipmentItems1.any((item) => item.value == name)) {
              equipmentItems1.add(DropdownMenuItem(value: name, child: Text(name)));
            }
            if (name != null && name != selectedEquipment1.value && !equipmentItems2.any((item) => item.value == name)) {
              equipmentItems2.add(DropdownMenuItem(value: name, child: Text(name)));
            }
          });
        });
        print(startingEquipmentOptionsRaw);

        for (var option in proficiencyOptions) {
          final String name = option["item"]["name"];
          if (name != selectedProficiency2.value) {
            proficiencyItems1.add(DropdownMenuItem(value: name, child: Text(name)));
          }
          if (name != selectedProficiency1.value) {
            proficiencyItems2.add(DropdownMenuItem(value: name, child: Text(name)));
          }
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Text(hitDie, style: textStyle),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Text("Proficiencies: $proficiencies", style: textStyle),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Text("Saving Throws: $savingThrows", style: textStyle),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Choose first proficiency',
                  labelStyle: textStyle,
                ),
                value: selectedProficiency1.value,
                onChanged: (newValue) {
                  selectedProficiency1.value = newValue;
                },
                items: proficiencyItems1,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Choose second proficiency',
                  labelStyle: textStyle,
                ),
                value: selectedProficiency2.value,
                onChanged: (newValue) {
                  selectedProficiency2.value = newValue;
                },
                items: proficiencyItems2,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Text("Starting Equipment: $startingEquipment", style: textStyle),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Choose first equipment',
                  labelStyle: textStyle,
                ),
                value: selectedEquipment1.value,
                onChanged: (newValue) {
                  selectedEquipment1.value = newValue;
                },
                items: equipmentItems1,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Choose second equipment',
                  labelStyle: textStyle,
                ),
                value: selectedEquipment2.value,
                onChanged: (newValue) {
                  selectedEquipment2.value = newValue;
                },
                items: equipmentItems2,
              ),

              // Additional widgets for subclasses, starting equipment, etc.
            ],
          ),
        );
      },
    );
  }
}