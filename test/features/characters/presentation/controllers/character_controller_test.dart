import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mythos_manager/features/characters/application/character_service.dart';
import 'package:mythos_manager/features/characters/domain/character.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/character_controller.dart';

import '../../../../provider_container.dart';

class MockCharacterService extends Mock implements CharacterService {}

void main() {
  group("CharacterController tests", () {
    Character character = Character(
      skillProficiencies: {"perception", "arcana"},
      equipmentProficiencies: {"sword", "armor"},
      equipment: {"longsword", "leather armor"},
      race: "Elf",
      subrace: "High Elf",
      size: "Medium",
      speed: 30,
      abilityScoreIncreases: {"str": 2, "dex": 1},
      racialTraits: {"Dark vision", "Resistance"},
      className: "Wizard",
      subclass: "Evocation",
      hitDie: 12,
      savingThrows: {"wis", "int"},
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

    late MockCharacterService mockCharacterService;

    setUp(() {
      mockCharacterService = MockCharacterService();
    });

    test("createCharacter calls service createCharacter", () async {
      final container = createContainer(overrides: [
        characterServiceProvider.overrideWith((ref) {
          return mockCharacterService;
        })
      ]);

      when(() => mockCharacterService.createCharacter(character))
          .thenAnswer((invocation) async => true);

      container.read(characterControllerProvider.notifier).createCharacter(character);

      verify(() => mockCharacterService.createCharacter(character))
          .called(1);
    });

    test("build calls service fetchCharacters of service", () async {
      final container = createContainer(overrides: [
        characterServiceProvider.overrideWith((ref) {
          return mockCharacterService;
        })
      ]);

      when(() => mockCharacterService.fetchCharacters()).thenAnswer((invocation) async => []);

      expectLater(container.read(characterControllerProvider.future), completion([]));

      verify(() =>  mockCharacterService.fetchCharacters()).called(1);
    });
  });
}
