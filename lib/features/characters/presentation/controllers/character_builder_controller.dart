import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/domain/character.dart';

/// Provides a [CharacterBuilderController] for character creation
final characterBuilderProvider = StateProvider<CharacterBuilderController>(
    (ref) => CharacterBuilderController());

/// Used to piece together a [Character] in the creation form.
///
/// Author: Liam Welsh
class CharacterBuilderController {
  /// Selected race of [Character]
  String? race;

  /// Selected subrace of [Character]
  String? subrace;

  /// Selected class of [Character]
  String? className;

  /// Size of selected race
  String? size;

  /// Speed of [Character]
  int? speed;

  /// Hit die for the [Character]'s selected class.
  int? hitDie;

  /// Selected [Character] subclass
  String? subclass;

  /// Selected [Character] background
  String? background;

  /// The name of the feature from the [Character]'s selected background.
  String? backgroundFeatureName;

  /// The description of the feature from the [Character]'s selected background.
  String? backgroundFeatureDesc;

  /// Selected age of [Character]
  String? age;

  /// Selected weight of [Character]
  String? weight;

  /// Selected height of [Character]
  String? height;

  /// Selected backstory of [Character]
  String? backstory;

  /// Selected name of [Character]
  String? name;

  /// Selected alignment of [Character]
  String? alignment;

  /// Ability scores from selected race
  final Map<String, int> raceAbilityScores = {};

  /// Languages from selected race
  final Set<String> raceLanguages = {};

  /// The selected list of racial traits for the [Character]'s race.
  final Set<String> racialTraits = {};

  /// Equipment Proficiencies from selected race
  final Set<String> raceEquipmentProfs = {};

  /// Skill Proficiencies from selected race
  final Set<String> raceSkillProfs = {};

  /// Saving throws from selected class
  final Set<String> classSavingThrows = {};

  /// Equipment Proficiencies from selected class
  final Set<String> classEquipmentProfs = {};

  /// Skill Proficiencies from selected class
  final Set<String> classSkillProfs = {};

  /// Equipment from selected class
  final Set<String> classEquipment = {};

  /// Map of selected ability score increases
  final Map<String, int> selectedAbilityScoreIncreases = {};

  /// Skill Proficiencies from selected background
  final Set<String> backgroundSkillProfs = {};


  /// Equipment Proficiencies from selected background
  final Set<String> backgroundEquipmentProfs = {};

  /// Selected languages from selected background
  final Set<String> backgroundLanguages = {};

  /// Selected equipment from selected background
  final Set<String> backgroundEquipment = {};

  CharacterBuilderController();

  /// Converts a [CharacterBuilderController] to a [Character]
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
