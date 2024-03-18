import 'package:cloud_firestore/cloud_firestore.dart';

/// This model holds all relevant data for a [Character].
class Character {
  /// The id of the user who owns the character.
  String? userID;

  /// The list of skills the [Character] is proficient in.
  final List<String>? skillProficiencies;

  /// The list of equipment the [Character] is proficient in.
  final List<String>? equipmentProficiencies;

  /// The list of equipment(items) in the [Character]'s inventory.
  final List<String>? equipment;

  /// The race of the [Character].
  final String? race;

  /// The subrace of the [Character].
  final String? subrace;

  /// The size of the [Character]'s race.
  final String? size;

  /// The speed of the [Character].
  final int? speed;

  /// The list of languages the [Character] can speak.
  final List<String>? languages;

  /// Map of ability score increases per ability.
  ///
  /// Example
  /// ```
  /// {
  ///   "str": 2,
  ///   "dex": 1,
  ///   "con": 1
  /// }
  /// ```
  final Map<String, int>? abilityScoreIncreases;

  /// The list of racial traits for the [Character]'s race.
  final List<String>? racialTraits;

  /// The class of the [Character].
  final String? className;

  /// The subclass of the [Character].
  final String? subclass;

  /// The hit die for the [Character]'s class.
  ///
  /// Integer representative for number of sides to the dice.
  /// Example:
  /// hitDie = 6 --> d6
  final int? hitDie;

  /// The list of abilities the [Character]'s class has saving throws for.
  ///
  /// Example:
  /// ```
  /// ["wis", "str"]
  /// ```
  final List<String>? savingThrows;

  /// Map of ability score base value.
  ///
  /// Example
  /// ```
  /// {
  ///   "str": 18,
  ///   "dex": 10,
  ///   "con": 14,
  ///   "int": 12,
  ///   "wis": 16,
  ///   "cha": 9
  /// }
  /// ```
  final Map<String, int>? abilityScores;

  /// The background of the [Character].
  final String? background;

  /// The name of the feature from the [Character]'s background.
  final String? backgroundFeatureName;

  /// The description of the feature from the [Character]'s background.
  final String? backgroundFeatureDesc;

  /// The alignment of the [Character].
  final String? alignment;

  /// The age of the [Character].
  final String? age;

  /// The weight of the [Character].
  final String? weight;

  /// The height of the [Character].
  final String? height;

  /// The backstory of the [Character].
  final String? backstory;

  /// The name of the [Character].
  final String? name;

  Character({
    this.userID,
    this.skillProficiencies,
    this.equipmentProficiencies,
    this.equipment,
    this.race,
    this.subrace,
    this.size,
    this.speed,
    this.languages,
    this.abilityScoreIncreases,
    this.racialTraits,
    this.className,
    this.subclass,
    this.hitDie,
    this.savingThrows,
    this.abilityScores,
    this.background,
    this.backgroundFeatureName,
    this.backgroundFeatureDesc,
    this.alignment,
    this.age,
    this.weight,
    this.height,
    this.backstory,
    this.name,
  });

  /// Constructs a [Character] from a firestore data [snapshot].
  factory Character.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Character(
      userID: data?["user_id"],
      skillProficiencies: data?["skill_proficiencies"] is Iterable
          ? List.from(data?["skill_proficiencies"])
          : null,
      equipmentProficiencies: data?["equipment_proficiencies"] is Iterable
          ? List.from(data?["equipment_proficiencies"])
          : null,
      equipment:
          data?["equipment"] is Iterable ? List.from(data?["equipment"]) : null,
      race: data?["race"],
      subrace: data?["subrace"],
      size: data?["size"],
      speed: data?["speed"],
      languages:
          data?["languages"] is Iterable ? List.from(data?["languages"]) : null,
      abilityScoreIncreases: data?["ability_score_increases"] is Map
          ? Map.from(data?["ability_score_increases"])
          : null,
      racialTraits: data?["racial_traits"] is Iterable
          ? List.from(data?["racial_traits"])
          : null,
      className: data?["class"],
      subclass: data?["subclass"],
      hitDie: data?["hit_die"],
      savingThrows: data?["saving_throws"] is Iterable
          ? List.from(data?["saving_throws"])
          : null,
      abilityScores: data?["ability_scores"] is Map
          ? Map.from(data?["ability_scores"])
          : null,
      background: data?["background"],
      backgroundFeatureName: data?["background_feature_name"],
      backgroundFeatureDesc: data?["background_feature_desc"],
      alignment: data?["alignment"],
      age: data?["age"],
      weight: data?["weight"],
      height: data?["height"],
      backstory: data?["backstory"],
      name: data?["name"]
    );
  }

  /// Returns a map of a [Character]'s attributes to store in Firestore.
  Map<String, dynamic> toFirestore() {
    return {
      // General
      "user_id": userID,
      if (skillProficiencies != null) "skill_proficiencies": skillProficiencies,
      if (equipmentProficiencies != null)
        "equipment_proficiencies": equipmentProficiencies,
      if (equipment != null) "equipment": equipment,

      // Race
      if (race != null) "race": race,
      if (subrace != null) "subrace": subrace,
      if (size != null) "size": size,
      if (speed != null) "speed": speed,
      if (languages != null) "languages": languages,
      if (abilityScoreIncreases != null)
        "ability_score_increases": abilityScoreIncreases,
      if (racialTraits != null) "racial_traits": racialTraits,

      // Class
      if (className != null) "class": className,
      if (subclass != null) "subclass": subclass,
      if (hitDie != null) "hit_die": hitDie, // Number of sides
      if (savingThrows != null) "saving_throws": savingThrows,

      // Ability Score
      if (abilityScores != null) "ability_scores": abilityScores,

      // Background
      if (background != null) "background": background,
      if (backgroundFeatureName != null)
        "background_feature_name": backgroundFeatureName,
      if (backgroundFeatureDesc != null)
        "background_feature_desc": backgroundFeatureDesc,

      // Backstory
      if (alignment != null) "alignment": alignment,
      if (age != null) "age": age,
      if (weight != null) "weight": weight,
      if (height != null) "height": height,
      if (backstory != null) "backstory": backstory,
      if (name != null) "name": name
    };
  }
}
