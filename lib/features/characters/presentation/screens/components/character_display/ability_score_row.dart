import 'package:flutter/material.dart';

class AbilityScoreRow extends StatelessWidget {
  final Map<String, int> abilityScores;
  final Map<String, int> abilityScoreIncreases;
  final Set<String> savingThrows;

  const AbilityScoreRow(
      {super.key,
      required this.abilityScores,
      required this.abilityScoreIncreases,
      required this.savingThrows});

  @override
  Widget build(BuildContext context) {
    final strengthTotal =
        abilityScores["STR"] ?? 0 + (abilityScoreIncreases["STR"] ?? 0);
    final dexterityTotal =
        abilityScores["DEX"] ?? 0 + (abilityScoreIncreases["DEX"] ?? 0);
    final constitutionTotal =
        abilityScores["CON"] ?? 0 + (abilityScoreIncreases["CON"] ?? 0);
    final intelligenceTotal =
        abilityScores["INT"] ?? 0 + (abilityScoreIncreases["INT"] ?? 0);
    final wisdomTotal =
        abilityScores["WIS"] ?? 0 + (abilityScoreIncreases["WIS"] ?? 0);
    final charismaTotal =
        abilityScores["CHA"] ?? 0 + (abilityScoreIncreases["CHA"] ?? 0);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
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
                    color: const Color(0xFF90714A),
                    gradient: const RadialGradient(
                      colors: [Color(0xFF90714A), Colors.black],
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
                    color: const Color(0xFF90714A),
                    gradient: const RadialGradient(
                      colors: [Color(0xFF90714A), Colors.black],
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
                    color: const Color(0xFF90714A),
                    gradient: const RadialGradient(
                      colors: [Color(0xFF90714A), Colors.black],
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
                    color: const Color(0xFF90714A),
                    gradient: const RadialGradient(
                      colors: [Color(0xFF90714A), Colors.black],
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
                    color: const Color(0xFF90714A),
                    gradient: const RadialGradient(
                      colors: [Color(0xFF90714A), Colors.black],
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
                    color: const Color(0xFF90714A),
                    gradient: const RadialGradient(
                      colors: [Color(0xFF90714A), Colors.black],
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
      ),
    );
  }
}
