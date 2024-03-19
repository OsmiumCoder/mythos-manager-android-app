import 'package:flutter_test/flutter_test.dart';
import 'package:mythos_manager/features/characters/domain/character.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/character_builder_controller.dart';

void main() {
  group("CharacterBuilderController tests", () {
    test("toCharacter spreads skillProficiencies", () {
      final CharacterBuilderController characterBuilderController = CharacterBuilderController();
      characterBuilderController.raceSkillProfs.add("test1");
      characterBuilderController.classSkillProfs.add("test2");
      characterBuilderController.backgroundSkillProfs.add("test3");

      Character character = characterBuilderController.toCharacter();

      expect(character.skillProficiencies, {"test1", "test2", "test3"});
    });

    test("toCharacter spreads equipmentProficiencies", () {
      final CharacterBuilderController characterBuilderController = CharacterBuilderController();
      characterBuilderController.raceEquipmentProfs.add("test1");
      characterBuilderController.classEquipmentProfs.add("test2");
      characterBuilderController.backgroundEquipmentProfs.add("test3");

      Character character = characterBuilderController.toCharacter();

      expect(character.equipmentProficiencies, {"test1", "test2", "test3"});
    });

    test("toCharacter spreads equipment", () {
      final CharacterBuilderController characterBuilderController = CharacterBuilderController();
      characterBuilderController.backgroundEquipment.add("test1");
      characterBuilderController.classEquipment.add("test2");

      Character character = characterBuilderController.toCharacter();

      expect(character.equipment, {"test1", "test2"});
    });

  });
}
