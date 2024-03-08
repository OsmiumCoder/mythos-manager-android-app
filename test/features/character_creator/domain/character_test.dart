import 'package:flutter_test/flutter_test.dart';
import 'package:mythos_manager/features/character_creator/domain/character.dart';

void main() {
  group("Character model tests", () {
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

    test("fromFirestore returns correct Character model", () {
      expect(character.skillProficiencies, ["perception", "arcana"]);
      expect(character.equipmentProficiencies, ["sword", "armor"]);
      expect(character.equipment, ["longsword", "leather armor"]);
      expect(character.race, "Elf");
      expect(character.subrace, "High Elf");
      expect(character.size, "Medium");
      expect(character.speed, 30);
      expect(character.abilityScoreIncreases, {"str": 2, "dex": 1});
      expect(character.racialTraits, ["Dark vision", "Resistance"]);
      expect(character.className, "Wizard");
      expect(character.subclass, "Evocation");
      expect(character.hitDie, 12);
      expect(character.savingThrows, ["wis", "int"]);
      expect(character.abilityScores,
          {"str": 18, "dex": 10, "con": 14, "int": 12, "wis": 16, "cha": 9});
      expect(character.background, "Acolyte");
      expect(character.backgroundFeatureName, "Feature Name");
      expect(character.backgroundFeatureDesc, "A short description.");
      expect(character.alignment, "Lawful Good");
      expect(character.age, "300 years");
      expect(character.weight, "200 lbs.");
      expect(character.height, "6 feet");
      expect(
          character.backstory, "A tragic story with parents being murdered.");
    });

    test("toFirestore returns correct map", () {
      expect(character.toFirestore(), {
        'skill_proficiencies': ['perception', 'arcana'],
        'equipment_proficiencies': ['sword', 'armor'],
        'equipment': ['longsword', 'leather armor'],
        'race': 'Elf',
        'subrace': 'High Elf',
        'size': 'Medium',
        'speed': 30,
        'ability_score_increases': {'str': 2, 'dex': 1},
        'racial_traits': ['Dark vision', 'Resistance'],
        'class': 'Wizard',
        'subclass': 'Evocation',
        'hit_die': 12,
        'saving_throws': ['wis', 'int'],
        'ability_scores': {
          'str': 18,
          'dex': 10,
          'con': 14,
          'int': 12,
          'wis': 16,
          'cha': 9
        },
        'background': 'Acolyte',
        'background_feature_name': 'Feature Name',
        'background_feature_desc': 'A short description.',
        'alignment': 'Lawful Good',
        'age': '300 years',
        'weight': '200 lbs.',
        'height': '6 feet',
        'backstory': 'A tragic story with parents being murdered.'
      });
    });
  });
}
