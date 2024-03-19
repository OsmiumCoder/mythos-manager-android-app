import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mythos_manager/features/characters/data/character_repository.dart';
import 'package:mythos_manager/features/characters/domain/character.dart';

import '../../../provider_container.dart';

void main() {
  group("CharacterRepository tests", () {
    Character character = Character(
      userID: "valid-id",
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
    Character otherIDCharacter = Character(
      userID: "other-id",
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

    late FakeFirebaseFirestore fakeFirebaseFirestore;

    setUp(() {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
    });

    test("fetchCharactersForUser returns users characters", () async {
      final container = createContainer(overrides: [
        characterRepositoryProvider.overrideWith((ref) {
          return CharacterRepository(fakeFirebaseFirestore);
        })
      ]);

      // add a test character
      fakeFirebaseFirestore
          .collection("characters")
          .withConverter(
              fromFirestore: Character.fromFirestore,
              toFirestore: (Character character, options) =>
                  character.toFirestore())
          .add(character);

      List<Character> characters = await container
          .read(characterRepositoryProvider)
          .fetchCharactersForUser("valid-id");

      expect(characters, isA<List<Character>>());
      expect(characters.length, 1);
      expect(characters.first.userID, "valid-id");
    });

    test("fetchCharactersForUser returns only the characters of given user id",
        () async {
      final container = createContainer(overrides: [
        characterRepositoryProvider.overrideWith((ref) {
          return CharacterRepository(fakeFirebaseFirestore);
        })
      ]);

      // add a test character
      fakeFirebaseFirestore
          .collection("characters")
          .withConverter(
              fromFirestore: Character.fromFirestore,
              toFirestore: (Character character, options) =>
                  character.toFirestore())
          .add(character);

      // add character that should not be returned
      fakeFirebaseFirestore
          .collection("characters")
          .withConverter(
              fromFirestore: Character.fromFirestore,
              toFirestore: (Character character, options) =>
                  character.toFirestore())
          .add(otherIDCharacter);

      List<Character> characters = await container
          .read(characterRepositoryProvider)
          .fetchCharactersForUser("valid-id");

      expect(characters, isA<List<Character>>());
      expect(characters.length, 1);
    });
  });
}
