import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/domain/character.dart';

/// Provides a [CharacterBuilderController] for character creation
final characterBuilderProvider = StateProvider<CharacterBuilderController>(
    (ref) => CharacterBuilderController());

/// Used to piece together a [Character] in the creation form.
///
/// Author: Liam Welsh
class CharacterBuilderController {
  // TODO: document all attrs and method
  String? race;
  String? subrace;
  String? className;
  String? size;
  int? speed;
  int? hitDie;
  String? subclass;
  String? background;
  String? backgroundFeatureName;
  String? backgroundFeatureDesc;
  String? age;
  String? weight;
  String? height;
  String? backstory;
  String? name;
  String? alignment;

  final Map<String, int> raceAbilityScores = {};
  final Set<String> raceLanguages = {};
  final Set<String> racialTraits = {};
  final Set<String> raceEquipmentProfs = {};
  final Set<String> raceSkillProfs = {};

  final Set<String> classSavingThrows = {};
  final Set<String> classEquipmentProfs = {};
  final Set<String> classSkillProfs = {};
  final Set<String> classEquipment = {};

  final Map<String, int> selectedAbilityScoreIncreases = {};

  final Set<String> backgroundSkillProfs = {};
  final Set<String> backgroundEquipmentProfs = {};
  final Set<String> backgroundLanguages = {};
  final Set<String> backgroundEquipment = {};

  CharacterBuilderController();

  Character toCharacter() => Character(
        race: race,
        subrace: subrace,
        className: className,
        size: size,
        speed: speed,
        hitDie: hitDie,
        subclass: subclass,
        background: background,
        backgroundFeatureDesc: backgroundFeatureDesc,
        backgroundFeatureName: backgroundFeatureName,
        age: age,
        weight: weight,
        height: height,
        backstory: backstory,
        name: name,
        alignment: alignment,
        languages: {...backgroundLanguages, ...raceLanguages},
        skillProficiencies: {
          ...classSkillProfs,
          ...backgroundSkillProfs,
          ...raceSkillProfs
        },
        equipmentProficiencies: {
          ...classEquipmentProfs,
          ...backgroundEquipmentProfs,
          ...raceEquipmentProfs
        },
        equipment: {...backgroundEquipment, ...classEquipment},
        abilityScores: selectedAbilityScoreIncreases,
        abilityScoreIncreases: raceAbilityScores,
        racialTraits: racialTraits,
        savingThrows: classSavingThrows,
      );
}
