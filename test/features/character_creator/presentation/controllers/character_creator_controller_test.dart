import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mythos_manager/features/character_creator/application/character_creator_service.dart';
import 'package:mythos_manager/features/character_creator/domain/character.dart';
import 'package:mythos_manager/features/character_creator/presentation/controllers/character_creator_controller.dart';

import '../../../../provider_container.dart';

class MockCharacterCreatorService extends Mock
    implements CharacterCreatorService {}

void main() {
  group("CharacterCreatorController tests", () {
    Character character = Character(
      skillProficiencies: ["perception", "arcana"],
      equipmentProficiencies: ["sword", "armor"],
      equipment: ["longsword", "leather armor"],
      race: "Elf",
      subrace: "High Elf",
      size: "Medium",
      speed: 30,
      abilityScoreIncreases: {"str": 2, "dex": 1},
      racialTraits: ["Dark vision", "Resistance"],
      className: "Wizard",
      subclass: "Evocation",
      hitDie: 12,
      savingThrows: ["wis", "int"],
      abilityScores: {
        "str": 18,
        "dex": 10,
        "con": 14,
        "int": 12,
        "wis": 16,
        "cha": 9
      },
      background: "Acolyte",
      backgroundFeatureName: "Feature Name",
      backgroundFeatureDesc: "A short description.",
      alignment: "Lawful Good",
      age: "300 years",
      weight: "200 lbs.",
      height: "6 feet",
      backstory: "A tragic story with parents being murdered.",
    );

    late MockCharacterCreatorService mockCharacterCreatorService;

    setUp(() {
      mockCharacterCreatorService = MockCharacterCreatorService();
    });

    test("createCharacter calls service createCharacter", () async {
      final container = createContainer(overrides: [
        characterCreatorControllerProvider.overrideWith((ref) {
          return CharacterCreatorController(mockCharacterCreatorService);
        })
      ]);

      when(() => mockCharacterCreatorService.createCharacter(character))
          .thenAnswer((invocation) async => true);
      await container.read(characterCreatorControllerProvider).createCharacter(character);

      verify(() => mockCharacterCreatorService.createCharacter(character))
          .called(1);
    });
  });
}
