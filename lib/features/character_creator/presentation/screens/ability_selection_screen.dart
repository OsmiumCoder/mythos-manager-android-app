import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/character_creator/presentation/controllers/character_builder_controller.dart';
import 'package:mythos_manager/features/character_creator/presentation/controllers/dnd_api_controller.dart';
import 'package:mythos_manager/features/character_creator/presentation/screens/components/ability_selection/ability_selection_row.dart';
import 'package:mythos_manager/routing/app_router.dart';

/// Author: Liam Welsh
class AbilitySelectionScreen extends HookConsumerWidget {
  const AbilitySelectionScreen({super.key});

  int _getBonus(List abilityBonuses, String ability) {
    final filtered = abilityBonuses
        .where((bonus) => bonus["ability_score"]["index"] == ability)
        .toList();

    return filtered.isEmpty ? 0 : filtered[0]["bonus"];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController strController = useTextEditingController();
    final TextEditingController dexController = useTextEditingController();
    final TextEditingController conController = useTextEditingController();
    final TextEditingController intController = useTextEditingController();
    final TextEditingController wisController = useTextEditingController();
    final TextEditingController chaController = useTextEditingController();

    useListenable(strController);
    useListenable(dexController);
    useListenable(conController);
    useListenable(intController);
    useListenable(wisController);
    useListenable(chaController);

    final characterBuilder = ref.watch(characterBuilderProvider.notifier);

    useEffect(() {
      characterBuilder.state.selectedAbilityScoreIncreases.clear();
      return null;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Character Creator"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future:
              ref.watch(dndApiController).getRace(characterBuilder.state.race!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final abilityBonuses = snapshot.data!["ability_bonuses"] as List;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Text(
                        "Total",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  AbilitySelectionRow(
                      controller: strController,
                      bonus: _getBonus(abilityBonuses, "str"),
                      type: "STR"),
                  AbilitySelectionRow(
                      controller: dexController,
                      bonus: _getBonus(abilityBonuses, "dex"),
                      type: "DEX"),
                  AbilitySelectionRow(
                      controller: conController,
                      bonus: _getBonus(abilityBonuses, "con"),
                      type: "CON"),
                  AbilitySelectionRow(
                      controller: intController,
                      bonus: _getBonus(abilityBonuses, "int"),
                      type: "INT"),
                  AbilitySelectionRow(
                      controller: wisController,
                      bonus: _getBonus(abilityBonuses, "wis"),
                      type: "WIS"),
                  AbilitySelectionRow(
                      controller: chaController,
                      bonus: _getBonus(abilityBonuses, "cha"),
                      type: "CHA"),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ElevatedButton(
                      child: const Text("Select Scores"),
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRouter.backgroundSelectionScreen);
                      },
                    ),
                  )
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
