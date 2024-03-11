import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mythos_manager/features/authentication/data/authentication_repository.dart';
import 'package:mythos_manager/features/authentication/exceptions/no_user_found_exception.dart';
import 'package:mythos_manager/features/character_creator/application/character_creator_service.dart';
import 'package:mythos_manager/features/character_creator/data/character_creator_repository.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:mythos_manager/features/character_creator/domain/character.dart';

import '../../../provider_container.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockCharacterCreatorRepository extends Mock
    implements CharacterCreatorRepository {}

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
    late MockUser mockUser;
    late CharacterCreatorRepository mockCharacterCreatorRepository;

    setUp(() {
      mockAuthRepo = MockAuthenticationRepository();
      mockUser = MockUser(uid: "valid-id");
      mockCharacterCreatorRepository = MockCharacterCreatorRepository();
    });

    test("createCharacter calls repo createCharacter", () async {
      final container = createContainer(overrides: [
        characterCreatorServiceProvider.overrideWith((ref) {
          return CharacterCreatorService(
              mockAuthRepo, mockCharacterCreatorRepository);
        })
      ]);

      when(() => mockAuthRepo.currentUser()).thenReturn(mockUser);
      when(() => mockCharacterCreatorRepository.createCharacter(character))
          .thenAnswer((invocation) async => true);

      await container.read(characterCreatorServiceProvider).createCharacter(character);

      verify(() => mockCharacterCreatorRepository.createCharacter(character))
          .called(1);
    });

    test("createCharacter adds correct userID and stores model", () async {
      final container = createContainer(overrides: [
        characterCreatorServiceProvider.overrideWith((ref) {
          return CharacterCreatorService(
              mockAuthRepo, mockCharacterCreatorRepository);
        })
      ]);

      when(() => mockAuthRepo.currentUser()).thenReturn(null);

      expectLater(
          container.read(characterCreatorServiceProvider).createCharacter(character),
          throwsA(isA<NoUserFoundException>()));
    });
  });
}
