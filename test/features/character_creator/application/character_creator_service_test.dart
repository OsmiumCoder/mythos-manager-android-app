import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mythos_manager/features/authentication/data/authentication_repository.dart';
import 'package:mythos_manager/features/character_creator/application/character_creator_service.dart';
import 'package:mythos_manager/features/character_creator/data/character_creator_repository.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:mythos_manager/features/character_creator/domain/character.dart';

import '../../../provider_container.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  group("CharacterCreatorService tests", () {
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

    late AuthenticationRepository mockAuthRepo;
    late FakeFirebaseFirestore fakeFirebaseFirestore;
    late CharacterCreatorRepository characterCreatorRepository;
    late MockUser mockUser;

    setUp(() {
      mockAuthRepo = MockAuthenticationRepository();
      fakeFirebaseFirestore = FakeFirebaseFirestore();
      characterCreatorRepository =
          CharacterCreatorRepository(fakeFirebaseFirestore);
      mockUser = MockUser(uid: "valid-id");
    });

    test("createCharacter adds correct userID and stores model", () async {
      final container = createContainer(overrides: [
        characterCreatorService.overrideWith((ref) {
          return CharacterCreatorService(
              mockAuthRepo, characterCreatorRepository);
        })
      ]);

      when(() => mockAuthRepo.currentUser()).thenReturn(mockUser);

      await container.read(characterCreatorService).createCharacter(character);

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

    test("createCharacter adds correct userID and stores model", () async {
      final container = createContainer(overrides: [
        characterCreatorService.overrideWith((ref) {
          return CharacterCreatorService(
              mockAuthRepo, characterCreatorRepository);
        })
      ]);

      when(() => mockAuthRepo.currentUser()).thenReturn(null);

      expectLater(container.read(characterCreatorService).createCharacter(character), throwsA(isA<NoUserFoundException>()));

    });
  });
}
