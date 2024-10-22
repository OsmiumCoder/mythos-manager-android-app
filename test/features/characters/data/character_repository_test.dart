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
      isPublic: true,
    );

    Character otherClassAndSubclassCharacter = Character(
      userID: "other-other-id",
      skillProficiencies: {"perception", "arcana"},
      equipmentProficiencies: {"sword", "armor"},
      equipment: {"longsword", "leather armor"},
      race: "Elf",
      subrace: "High Elf",
      size: "Medium",
      speed: 30,
      abilityScoreIncreases: {"str": 2, "dex": 1},
      racialTraits: {"Dark vision", "Resistance"},
      className: "class",
      subclass: "subclass",
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
      isPublic: true,
    );

    late FakeFirebaseFirestore fakeFirebaseFirestore;

    setUp(() {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
    });

    test("createCharacter creates a character document entry with valid data",
        () async {
      final container = createContainer(overrides: [
        characterRepositoryProvider.overrideWith((ref) {
          return CharacterRepository(fakeFirebaseFirestore);
        })
      ]);

      container.read(characterRepositoryProvider).createCharacter(character);

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

      expect(storedCharacter.userID, "valid-id");
      expect(storedCharacter.skillProficiencies, {"perception", "arcana"});
      expect(storedCharacter.equipmentProficiencies, {"sword", "armor"});
      expect(storedCharacter.equipment, {"longsword", "leather armor"});
      expect(storedCharacter.race, "Elf");
      expect(storedCharacter.subrace, "High Elf");
      expect(storedCharacter.size, "Medium");
      expect(storedCharacter.speed, 30);
      expect(storedCharacter.abilityScoreIncreases, {"str": 2, "dex": 1});
      expect(storedCharacter.racialTraits, {"Dark vision", "Resistance"});
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
      expect(storedCharacter.isPublic, false);
    });

    test("createCharacter generates id for all characters even if same data",
        () async {
      final container = createContainer(overrides: [
        characterRepositoryProvider.overrideWith((ref) {
          return CharacterRepository(fakeFirebaseFirestore);
        })
      ]);

      container.read(characterRepositoryProvider).createCharacter(character);
      container.read(characterRepositoryProvider).createCharacter(character);

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

    test("updateCharacter updates the correct data", () async {
      final container = createContainer(overrides: [
        characterRepositoryProvider.overrideWith((ref) {
          return CharacterRepository(fakeFirebaseFirestore);
        })
      ]);

      container.read(characterRepositoryProvider).createCharacter(character);

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

      storedCharacter.isPublic = true;

      container
          .read(characterRepositoryProvider)
          .updateCharacter(storedCharacter);

      final updatedSnapshot = await fakeFirebaseFirestore
          .collection('characters')
          .withConverter(
              fromFirestore: Character.fromFirestore,
              toFirestore: (Character character, options) =>
                  character.toFirestore())
          .get();

      // only one character should be stored
      expect(updatedSnapshot.docs.length, 1);

      Character updatedCharacter = updatedSnapshot.docs.first.data();

      expect(updatedCharacter.userID, "valid-id");
      expect(updatedCharacter.skillProficiencies, {"perception", "arcana"});
      expect(updatedCharacter.equipmentProficiencies, {"sword", "armor"});
      expect(updatedCharacter.equipment, {"longsword", "leather armor"});
      expect(updatedCharacter.race, "Elf");
      expect(updatedCharacter.subrace, "High Elf");
      expect(updatedCharacter.size, "Medium");
      expect(updatedCharacter.speed, 30);
      expect(updatedCharacter.abilityScoreIncreases, {"str": 2, "dex": 1});
      expect(updatedCharacter.racialTraits, {"Dark vision", "Resistance"});
      expect(updatedCharacter.className, "Wizard");
      expect(updatedCharacter.subclass, "Evocation");
      expect(updatedCharacter.hitDie, 12);
      expect(updatedCharacter.savingThrows, ["wis", "int"]);
      expect(updatedCharacter.abilityScores,
          {"str": 18, "dex": 10, "con": 14, "int": 12, "wis": 16, "cha": 9});
      expect(updatedCharacter.background, "Acolyte");
      expect(updatedCharacter.backgroundFeatureName, "Feature Name");
      expect(updatedCharacter.backgroundFeatureDesc, "A short description.");
      expect(updatedCharacter.alignment, "Lawful Good");
      expect(updatedCharacter.age, "300 years");
      expect(updatedCharacter.weight, "200 lbs.");
      expect(updatedCharacter.height, "6 feet");
      expect(updatedCharacter.backstory,
          "A tragic story with parents being murdered.");
      expect(updatedCharacter.isPublic, true);
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

    test("fetchCharacterById returns only the character of given id", () async {
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

      Character? fetchedCharacter = await container
          .read(characterRepositoryProvider)
          .fetchCharacterById(characters[0].id!);

      expect(fetchedCharacter == null, false);
      expect(fetchedCharacter?.id, characters[0].id);
    });

    test(
        "fetchPublicCharacters returns only public characters that match filter parameters",
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
          .add(otherIDCharacter);

      // add character that should not be returned
      fakeFirebaseFirestore
          .collection("characters")
          .withConverter(
              fromFirestore: Character.fromFirestore,
              toFirestore: (Character character, options) =>
                  character.toFirestore())
          .add(otherClassAndSubclassCharacter);

      List<Character> characters = await container
          .read(characterRepositoryProvider)
          .fetchPublicCharacters("Wizard", "Evocation");

      expect(characters, isA<List<Character>>());
      expect(characters.length, 1);
    });

    test(
        "fetchPublicCharacters returns all public characters when no filter params provided",
        () async {
      final container = createContainer(overrides: [
        characterRepositoryProvider.overrideWith((ref) {
          return CharacterRepository(fakeFirebaseFirestore);
        })
      ]);

      // private character (should not be returned)
      fakeFirebaseFirestore
          .collection("characters")
          .withConverter(
              fromFirestore: Character.fromFirestore,
              toFirestore: (Character character, options) =>
                  character.toFirestore())
          .add(character);

      // public character (should be returned)
      fakeFirebaseFirestore
          .collection("characters")
          .withConverter(
              fromFirestore: Character.fromFirestore,
              toFirestore: (Character character, options) =>
                  character.toFirestore())
          .add(otherIDCharacter);

      // public character (should be returned)
      fakeFirebaseFirestore
          .collection("characters")
          .withConverter(
              fromFirestore: Character.fromFirestore,
              toFirestore: (Character character, options) =>
                  character.toFirestore())
          .add(otherClassAndSubclassCharacter);

      List<Character> characters = await container
          .read(characterRepositoryProvider)
          .fetchPublicCharacters(null, null);

      expect(characters, isA<List<Character>>());
      expect(characters.length, 2);
    });
  });
}
