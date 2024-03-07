import 'package:cloud_firestore/cloud_firestore.dart';

class CharacterModel {
  final List<String>? skillProficiencies;
  final List<String>? equipmentProficiencies;
  final List<String>? equipment;

  final String? race;
  final String? subrace;
  final String? size;
  final int? speed;
  final List<String>? languages;
  final Map<String, int>? abilityScoreIncreases;
  final List<String>? traits;

  final String? className;
  final String? subclass;
  final int? hitDie;
  final List<String>? savingThrows;

  final Map<String, int>? abilityScores;

  final String? background;
  final String? backgroundFeatureName;
  final String? backgroundFeatureDesc;

  final String? alignment;
  final String? age;
  final String? weight;
  final String? height;
  final String? backstory;

  CharacterModel(
      {this.skillProficiencies,
      this.equipmentProficiencies,
      this.equipment,
      this.race,
      this.subrace,
      this.size,
      this.speed,
      this.languages,
      this.abilityScoreIncreases,
      this.traits,
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
      this.backstory});

  factory CharacterModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return CharacterModel(
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
      abilityScoreIncreases:
          data?["ability_score_increases"] is Map ? Map.from(data?[""]) : null,
      traits: data?["traits"] is Iterable ? List.from(data?["traits"]) : null,
      className: data?["class"],
      subclass: data?["subclass"],
      hitDie: data?["hit_die"],
      savingThrows: data?["saving_throws"] is Iterable
          ? List.from(data?["saving_throws"])
          : null,
      abilityScores:
          data?["ability_scores"] is Map ? Map.from(data?[""]) : null,
      background: data?["background"],
      backgroundFeatureName: data?["background_feature_name"],
      backgroundFeatureDesc: data?["background_feature_desc"],
      alignment: data?["alignment"],
      age: data?["age"],
      weight: data?["weight"],
      height: data?["height"],
      backstory: data?["backstory"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
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
      if (traits != null) "traits": traits,

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
      if (backstory != null) "backstory": backstory
    };
  }
}
