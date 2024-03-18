import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// This model holds all relevant data for a [Character].
class Character extends Equatable {
  /// The id of the user who owns the character.
  String? userID;

  /// The list of skills the [Character] is proficient in.
  final Set<String>? skillProficiencies;

  /// The list of equipment the [Character] is proficient in.
  final Set<String>? equipmentProficiencies;

  /// The list of equipment(items) in the [Character]'s inventory.
  final Set<String>? equipment;

  /// The race of the [Character].
  String? race;

  /// The subrace of the [Character].
  String? subrace;

  /// The size of the [Character]'s race.
  String? size;

  /// The speed of the [Character].
  int? speed;

  /// The list of languages the [Character] can speak.
  final Set<String>? languages;

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
  final Set<String>? racialTraits;

  /// The class of the [Character].
  String? className;

  /// The subclass of the [Character].
  String? subclass;

  /// The hit die for the [Character]'s class.
  ///
  /// Integer representative for number of sides to the dice.
  /// Example:
  /// hitDie = 6 --> d6
  int? hitDie;

  /// The list of abilities the [Character]'s class has saving throws for.
  ///
  /// Example:
  /// ```
  /// ["wis", "str"]
  /// ```
  final Set<String>? savingThrows;

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
  String? background;

  /// The name of the feature from the [Character]'s background.
  String? backgroundFeatureName;

  /// The description of the feature from the [Character]'s background.
  String? backgroundFeatureDesc;

  /// The alignment of the [Character].
  String? alignment;

  /// The age of the [Character].
  String? age;

  /// The weight of the [Character].
  String? weight;

  /// The height of the [Character].
  String? height;

  /// The backstory of the [Character].
  String? backstory;

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

  factory Character.withCollectionsInitialized() {
    return Character(
      abilityScoreIncreases: {},
      abilityScores: {},
      equipment: {},
      equipmentProficiencies: {},
      languages: {},
      racialTraits: {},
      savingThrows: {},
      skillProficiencies: {},
    );
  }

  /// Constructs a [Character] from a firestore data [snapshot].
  factory Character.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Character(
        userID: data?["user_id"],
        skillProficiencies: data?["skill_proficiencies"] is Iterable
            ? Set.from(data?["skill_proficiencies"])
            : null,
        equipmentProficiencies: data?["equipment_proficiencies"] is Iterable
            ? Set.from(data?["equipment_proficiencies"])
            : null,
        equipment: data?["equipment"] is Iterable
            ? Set.from(data?["equipment"])
            : null,
        race: data?["race"],
        subrace: data?["subrace"],
        size: data?["size"],
        speed: data?["speed"],
        languages: data?["languages"] is Iterable
            ? Set.from(data?["languages"])
            : null,
        abilityScoreIncreases: data?["ability_score_increases"] is Map
            ? Map.from(data?["ability_score_increases"])
            : null,
        racialTraits: data?["racial_traits"] is Iterable
            ? Set.from(data?["racial_traits"])
            : null,
        className: data?["class"],
        subclass: data?["subclass"],
        hitDie: data?["hit_die"],
        savingThrows: data?["saving_throws"] is Iterable
            ? Set.from(data?["saving_throws"])
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
        name: data?["name"]);
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


  @override
  List<Object?> get props => [
    userID,
    skillProficiencies,
    equipmentProficiencies,
    equipment,
    race,
    subrace,
    size,
    speed,
    languages,
    abilityScoreIncreases,
    racialTraits,
    className,
    subrace,
    hitDie,
    savingThrows,
    abilityScores,
    background,
    backgroundFeatureName,
    backgroundFeatureDesc,
    alignment,
    age,
    weight,
    backstory,
    name,
  ];

  @override
  bool? get stringify => true;
}
