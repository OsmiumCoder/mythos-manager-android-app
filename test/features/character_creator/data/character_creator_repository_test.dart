import 'package:flutter_test/flutter_test.dart';
import 'package:mythos_manager/features/character_creator/data/character_creator_repository.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:mythos_manager/features/character_creator/domain/character.dart';

import '../../../provider_container.dart';

void main() {
  group("CharacterRepository tests", () {
    Character character = Character(
      userID: "user-id-valid",
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

    late FakeFirebaseFirestore fakeFirebaseFirestore;

    setUp(() {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
    });

    test("createCharacter creates a character document entry with valid data",
        () async {
      final container = createContainer(overrides: [
        characterCreatorRepository.overrideWith((ref) {
          return CharacterCreatorRepository(fakeFirebaseFirestore);
        })
      ]);

      container.read(characterCreatorRepository).createCharacter(character);

      final snapshot = await fakeFirebaseFirestore
          .collection('characters')
          .withConverter(
              fromFirestore: Character.fromFirestore,
              toFirestore: (Character character, options) =>
                  character.toFirestore())
          .get();

      // only one character should be stored
      expect(snapshot.docs.length, 1);

      Character storedCharacter = snapshot.docs.first.data();

      expect(storedCharacter.userID, "user-id-valid");
      expect(storedCharacter.skillProficiencies, ["perception", "arcana"]);
      expect(storedCharacter.equipmentProficiencies, ["sword", "armor"]);
      expect(storedCharacter.equipment, ["longsword", "leather armor"]);
      expect(storedCharacter.race, "Elf");
      expect(storedCharacter.subrace, "High Elf");
      expect(storedCharacter.size, "Medium");
      expect(storedCharacter.speed, 30);
      expect(storedCharacter.abilityScoreIncreases, {"str": 2, "dex": 1});
      expect(storedCharacter.racialTraits, ["Dark vision", "Resistance"]);
      expect(storedCharacter.className, "Wizard");
      expect(storedCharacter.subclass, "Evocation");
      expect(storedCharacter.hitDie, 12);
      expect(storedCharacter.savingThrows, ["wis", "int"]);
      expect(storedCharacter.abilityScores,
          {"str": 18, "dex": 10, "con": 14, "int": 12, "wis": 16, "cha": 9});
      expect(storedCharacter.background, "Acolyte");
      expect(storedCharacter.backgroundFeatureName, "Feature Name");
      expect(storedCharacter.backgroundFeatureDesc, "A short description.");
      expect(storedCharacter.alignment, "Lawful Good");
      expect(storedCharacter.age, "300 years");
      expect(storedCharacter.weight, "200 lbs.");
      expect(storedCharacter.height, "6 feet");
      expect(storedCharacter.backstory,
          "A tragic story with parents being murdered.");
    });

    test("createCharacter generates id for all characters even if same data",
        () async {
      final container = createContainer(overrides: [
        characterCreatorRepository.overrideWith((ref) {
          return CharacterCreatorRepository(fakeFirebaseFirestore);
        })
      ]);

      container.read(characterCreatorRepository).createCharacter(character);
      container.read(characterCreatorRepository).createCharacter(character);

      final snapshot = await fakeFirebaseFirestore
          .collection('characters')
          .withConverter(
              fromFirestore: Character.fromFirestore,
              toFirestore: (Character character, options) =>
                  character.toFirestore())
          .get();

      // two characters should be stored
      // even though they are the same we can have 2 of the same
      expect(snapshot.docs.length, 2);
    });
  });
}
