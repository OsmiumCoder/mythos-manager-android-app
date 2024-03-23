import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/domain/character.dart';
import 'package:mythos_manager/shared/extensions/capitalize.dart';

class MainCharacterDisplayScreen extends ConsumerWidget {
  final Character character;

  const MainCharacterDisplayScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                character.className!,
                style: const TextStyle(fontSize: 20),
              )),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Center(
                  child: Text(
                    "${character.race!.capitalize()}, ${character.subrace != null ? "${character.subrace!.capitalize()}, " : ""}${character.size}",
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
              AbilityScoreRowComponent(
                  abilityScores: character.abilityScores!,
                  abilityScoreIncreases: character.abilityScoreIncreases!,
                  savingThrows: character.savingThrows!),
              Card(
                child: Column(
                  children: [
                    const ListTile(
                      title: Text("Equipment", style: TextStyle(color: Colors.white, fontSize: 15),)
                    ),
                    ListView.builder(itemBuilder: (context, index) {
                      return Text(character.equipment!.elementAt(index));
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      );
  }
}

class AbilityScoreRowComponent extends StatelessWidget {
  final Map<String, int> abilityScores;
  final Map<String, int> abilityScoreIncreases;
  final Set<String> savingThrows;

  const AbilityScoreRowComponent(
      {super.key,
      required this.abilityScores,
      required this.abilityScoreIncreases,
      required this.savingThrows});

  @override
  Widget build(BuildContext context) {
    final strengthTotal =
        abilityScores["STR"]! + (abilityScoreIncreases["STR"] ?? 0);
    final dexterityTotal =
        abilityScores["DEX"]! + (abilityScoreIncreases["DEX"] ?? 0);
    final constitutionTotal =
        abilityScores["CON"]! + (abilityScoreIncreases["CON"] ?? 0);
    final intelligenceTotal =
        abilityScores["INT"]! + (abilityScoreIncreases["INT"] ?? 0);
    final wisdomTotal =
        abilityScores["WIS"]! + (abilityScoreIncreases["WIS"] ?? 0);
    final charismaTotal =
        abilityScores["CHA"]! + (abilityScoreIncreases["CHA"] ?? 0);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                savingThrows.contains("STR")
                    ? const Icon(
                        Icons.circle,
                        size: 15,
                      )
                    : const Icon(
                        Icons.circle_outlined,
                        size: 15,
                      ),
                const Text("STR"),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                  border: Border.all(width: 3),
                  shape: BoxShape.circle,
                  color: Colors.brown,
                  gradient: const RadialGradient(
                    colors: [Colors.brown, Colors.black],
                  )),
              child: Center(
                  child: Text(
                "$strengthTotal",
                style: const TextStyle(color: Colors.white),
              )),
            ),
            Text("+${(strengthTotal - 10) ~/ 2}")
          ],
        ),
        Column(
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                savingThrows.contains("DEX")
                    ? const Icon(
                        Icons.circle,
                        size: 15,
                      )
                    : const Icon(
                        Icons.circle_outlined,
                        size: 15,
                      ),
                const Text("DEX"),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                  border: Border.all(width: 3),
                  shape: BoxShape.circle,
                  color: Colors.brown,
                  gradient: const RadialGradient(
                    colors: [Colors.brown, Colors.black],
                  )),
              child: Center(
                  child: Text(
                "$dexterityTotal",
                style: const TextStyle(color: Colors.white),
              )),
            ),
            Text("+${(dexterityTotal - 10) ~/ 2}")
          ],
        ),
        Column(
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                savingThrows.contains("CON")
                    ? const Icon(
                        Icons.circle,
                        size: 15,
                      )
                    : const Icon(
                        Icons.circle_outlined,
                        size: 15,
                      ),
                const Text("CON"),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                  border: Border.all(width: 3),
                  shape: BoxShape.circle,
                  color: Colors.brown,
                  gradient: const RadialGradient(
                    colors: [Colors.brown, Colors.black],
                  )),
              child: Center(
                  child: Text(
                "$constitutionTotal",
                style: const TextStyle(color: Colors.white),
              )),
            ),
            Text("+${(constitutionTotal - 10) ~/ 2}")
          ],
        ),
        Column(
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                savingThrows.contains("INT")
                    ? const Icon(
                        Icons.circle,
                        size: 15,
                      )
                    : const Icon(
                        Icons.circle_outlined,
                        size: 15,
                      ),
                const Text("INT"),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                  border: Border.all(width: 3),
                  shape: BoxShape.circle,
                  color: Colors.brown,
                  gradient: const RadialGradient(
                    colors: [Colors.brown, Colors.black],
                  )),
              child: Center(
                  child: Text(
                "$intelligenceTotal",
                style: const TextStyle(color: Colors.white),
              )),
            ),
            Text("+${(intelligenceTotal - 10) ~/ 2}")
          ],
        ),
        Column(
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                savingThrows.contains("WIS")
                    ? const Icon(
                        Icons.circle,
                        size: 15,
                      )
                    : const Icon(
                        Icons.circle_outlined,
                        size: 15,
                      ),
                const Text("WIS"),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                  border: Border.all(width: 3),
                  shape: BoxShape.circle,
                  color: Colors.brown,
                  gradient: const RadialGradient(
                    colors: [Colors.brown, Colors.black],
                  )),
              child: Center(
                  child: Text(
                "$wisdomTotal",
                style: const TextStyle(color: Colors.white),
              )),
            ),
            Text("+${(wisdomTotal - 10) ~/ 2}")
          ],
        ),
        Column(
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                savingThrows.contains("CHA")
                    ? const Icon(
                        Icons.circle,
                        size: 15,
                      )
                    : const Icon(
                        Icons.circle_outlined,
                        size: 15,
                      ),
                const Text("CHA"),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                  border: Border.all(width: 3),
                  shape: BoxShape.circle,
                  color: Colors.brown,
                  gradient: const RadialGradient(
                    colors: [Colors.brown, Colors.black],
                  )),
              child: Center(
                  child: Text(
                "$charismaTotal",
                style: const TextStyle(color: Colors.white),
              )),
            ),
            Text("+${(charismaTotal - 10) ~/ 2}")
          ],
        ),
      ],
    );
  }
}
