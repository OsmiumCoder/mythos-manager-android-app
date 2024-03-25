import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:mythos_manager/features/characters/data/dnd_api_repository.dart';

import '../../../provider_container.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group("DNDAPIRepository tests", () {
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
    });

    test('getAllRaces returns correct json data', () async {
      final container = createContainer(overrides: [
        dndApiRepository.overrideWith((ref) {
          return DNDAPIRepository(client: mockHttpClient);
        })
      ]);

      when(() => mockHttpClient
              .get(Uri.parse('https://www.dnd5eapi.co/api/races')))
          .thenAnswer((invocation) async => http.Response(allRaces, 200));

      final allRacesJson = await container.read(dndApiRepository).getAllRaces();
      expect(allRacesJson, isMap);
      expect(allRacesJson["count"], 9);
      expect(allRacesJson["results"], isList);
    });

    test('getRace returns correct json data', () async {
      final container = createContainer(overrides: [
        dndApiRepository.overrideWith((ref) {
          return DNDAPIRepository(client: mockHttpClient);
        })
      ]);

      when(() => mockHttpClient
              .get(Uri.parse('https://www.dnd5eapi.co/api/races/elf')))
          .thenAnswer((invocation) async => http.Response(singleRace, 200));

      final singleRaceJson =
          await container.read(dndApiRepository).getRace('elf');
      expect(singleRaceJson, isMap);
      expect(singleRaceJson.containsKey("index"), isTrue);
      expect(singleRaceJson.containsKey("name"), isTrue);
      expect(singleRaceJson.containsKey("speed"), isTrue);
      expect(singleRaceJson.containsKey("ability_bonuses"), isTrue);
      expect(singleRaceJson.containsKey("age"), isTrue);
      expect(singleRaceJson.containsKey("alignment"), isTrue);
      expect(singleRaceJson.containsKey("size"), isTrue);
      expect(singleRaceJson.containsKey("size_description"), isTrue);
      expect(singleRaceJson.containsKey("starting_proficiencies"), isTrue);
      expect(singleRaceJson.containsKey("languages"), isTrue);
      expect(singleRaceJson.containsKey("language_desc"), isTrue);
      expect(singleRaceJson.containsKey("traits"), isTrue);
      expect(singleRaceJson.containsKey("subraces"), isTrue);
    });

    test('getSubrace returns correct json data', () async {
      final container = createContainer(overrides: [
        dndApiRepository.overrideWith((ref) {
          return DNDAPIRepository(client: mockHttpClient);
        })
      ]);

      when(() => mockHttpClient
              .get(Uri.parse('https://www.dnd5eapi.co/api/subraces/high-elf')))
          .thenAnswer((invocation) async => http.Response(singleSubrace, 200));

      final singleSubraceJson =
          await container.read(dndApiRepository).getSubrace("high-elf");
      expect(singleSubraceJson, isMap);
      expect(singleSubraceJson.containsKey("index"), isTrue);
      expect(singleSubraceJson.containsKey("name"), isTrue);
      expect(singleSubraceJson.containsKey("race"), isTrue);
      expect(singleSubraceJson.containsKey("desc"), isTrue);
      expect(singleSubraceJson.containsKey("ability_bonuses"), isTrue);
      expect(singleSubraceJson.containsKey("starting_proficiencies"), isTrue);
      expect(singleSubraceJson.containsKey("languages"), isTrue);
      expect(singleSubraceJson.containsKey("language_options"), isTrue);
      expect(singleSubraceJson.containsKey("racial_traits"), isTrue);
    });

    test('getAllClasses returns correct json data', () async {
      final container = createContainer(overrides: [
        dndApiRepository.overrideWith((ref) {
          return DNDAPIRepository(client: mockHttpClient);
        })
      ]);

      when(() => mockHttpClient
              .get(Uri.parse('https://www.dnd5eapi.co/api/classes')))
          .thenAnswer((invocation) async => http.Response(allClasses, 200));

      final allClassesJson =
          await container.read(dndApiRepository).getAllClasses();
      expect(allClassesJson, isMap);
      expect(allClassesJson["count"], 12);
      expect(allClassesJson["results"], isList);
    });

    test('getClass returns correct json data', () async {
      final container = createContainer(overrides: [
        dndApiRepository.overrideWith((ref) {
          return DNDAPIRepository(client: mockHttpClient);
        })
      ]);

      when(() => mockHttpClient
              .get(Uri.parse('https://www.dnd5eapi.co/api/classes/barbarian')))
          .thenAnswer((invocation) async => http.Response(singleClass, 200));

      final singleClassJson =
          await container.read(dndApiRepository).getClass("barbarian");
      expect(singleClassJson, isMap);
      expect(singleClassJson.containsKey("index"), isTrue);
      expect(singleClassJson.containsKey("name"), isTrue);
      expect(singleClassJson.containsKey("hit_die"), isTrue);
      expect(singleClassJson.containsKey("proficiency_choices"), isTrue);
      expect(singleClassJson.containsKey("proficiencies"), isTrue);
      expect(singleClassJson.containsKey("saving_throws"), isTrue);
      expect(singleClassJson.containsKey("starting_equipment"), isTrue);
      expect(singleClassJson.containsKey("starting_equipment_options"), isTrue);
      expect(singleClassJson.containsKey("class_levels"), isTrue);
      expect(singleClassJson.containsKey("subclasses"), isTrue);
    });

    test('getSubclass returns correct json data', () async {
      final container = createContainer(overrides: [
        dndApiRepository.overrideWith((ref) {
          return DNDAPIRepository(client: mockHttpClient);
        })
      ]);

      when(() => mockHttpClient.get(
              Uri.parse('https://www.dnd5eapi.co/api/subclasses/berserker')))
          .thenAnswer((invocation) async => http.Response(singleSubclass, 200));

      final singleSubclassJson =
          await container.read(dndApiRepository).getSubclass("berserker");
      expect(singleSubclassJson, isMap);
      expect(singleSubclassJson.containsKey("index"), isTrue);
      expect(singleSubclassJson.containsKey("class"), isTrue);
      expect(singleSubclassJson.containsKey("name"), isTrue);
      expect(singleSubclassJson.containsKey("subclass_flavor"), isTrue);
      expect(singleSubclassJson.containsKey("desc"), isTrue);
      expect(singleSubclassJson.containsKey("subclass_levels"), isTrue);
      expect(singleSubclassJson.containsKey("spells"), isTrue);
    });

    test('getAllBackgrounds returns correct json data', () async {
      final container = createContainer(overrides: [
        dndApiRepository.overrideWith((ref) {
          return DNDAPIRepository(client: mockHttpClient);
        })
      ]);

      when(() => mockHttpClient
              .get(Uri.parse('https://www.dnd5eapi.co/api/backgrounds')))
          .thenAnswer((invocation) async => http.Response(allBackgrounds, 200));

      final allBackgroundsJson =
          await container.read(dndApiRepository).getAllBackgrounds();
      expect(allBackgroundsJson, isMap);
      expect(allBackgroundsJson["count"], 1);
      expect(allBackgroundsJson["results"], isList);
    });

    test('getBackground returns correct json data', () async {
      final container = createContainer(overrides: [
        dndApiRepository.overrideWith((ref) {
          return DNDAPIRepository(client: mockHttpClient);
        })
      ]);

      when(() => mockHttpClient.get(
              Uri.parse('https://www.dnd5eapi.co/api/backgrounds/acolyte')))
          .thenAnswer(
              (invocation) async => http.Response(singleBackground, 200));

      final singleBackgroundJson =
          await container.read(dndApiRepository).getBackground("acolyte");
      expect(singleBackgroundJson, isMap);
      expect(singleBackgroundJson.containsKey("index"), isTrue);
      expect(singleBackgroundJson.containsKey("name"), isTrue);
      expect(
          singleBackgroundJson.containsKey("starting_proficiencies"), isTrue);
      expect(singleBackgroundJson.containsKey("language_options"), isTrue);
      expect(singleBackgroundJson.containsKey("starting_equipment"), isTrue);
      expect(singleBackgroundJson.containsKey("starting_equipment_options"),
          isTrue);
      expect(singleBackgroundJson.containsKey("feature"), isTrue);
    });

    test('getAllLanguages returns correct json data', () async {
      final container = createContainer(overrides: [
        dndApiRepository.overrideWith((ref) {
          return DNDAPIRepository(client: mockHttpClient);
        })
      ]);

      when(() => mockHttpClient
              .get(Uri.parse('https://www.dnd5eapi.co/api/languages')))
          .thenAnswer((invocation) async => http.Response(allLanguages, 200));

      final allLanguagesJson =
          await container.read(dndApiRepository).getAllLanguages();
      expect(allLanguagesJson, isMap);
      expect(allLanguagesJson["count"], 16);
      expect(allLanguagesJson["results"], isList);
    });

    test('getSpellsForClass returns correct json data', () async {
      final container = createContainer(overrides: [
        dndApiRepository.overrideWith((ref) {
          return DNDAPIRepository(client: mockHttpClient);
        })
      ]);

      when(() => mockHttpClient.get(
              Uri.parse('https://www.dnd5eapi.co/api/classes/wizard/spells/')))
          .thenAnswer((invocation) async => http.Response(spellsForClass, 200));

      when(() => mockHttpClient
              .get(Uri.parse('https://www.dnd5eapi.co/api/spells/acid-splash')))
          .thenAnswer(
              (invocation) async => http.Response(acidSplashSpell, 200));

      final spellsForClassJson =
          await container.read(dndApiRepository).getSpellsForClass("wizard");
      expect(spellsForClassJson, isList);
    });

    test("getClassFeatures returns correct json data", () async {
      final container = createContainer(overrides: [
        dndApiRepository.overrideWith((ref) {
          return DNDAPIRepository(client: mockHttpClient);
        })
      ]);

      when(() => mockHttpClient.get(Uri.parse(
              'https://www.dnd5eapi.co/api/classes/barbarian/levels')))
          .thenAnswer((invocation) async => http.Response(levelsForClass, 200));

      when(() => mockHttpClient
              .get(Uri.parse('https://www.dnd5eapi.co/api/features/rage')))
          .thenAnswer((invocation) async => http.Response(classFeature, 200));

      final featuresForClassJson =
          await container.read(dndApiRepository).getClassFeatures("barbarian");
      expect(featuresForClassJson, isList);
    });

    test("getSubclassFeatures returns correct json data", () async {
      final container = createContainer(overrides: [
        dndApiRepository.overrideWith((ref) {
          return DNDAPIRepository(client: mockHttpClient);
        })
      ]);

      when(() => mockHttpClient.get(Uri.parse(
              'https://www.dnd5eapi.co/api/subclasses/berserker/levels')))
          .thenAnswer(
              (invocation) async => http.Response(levelsForSubclass, 200));

      when(() => mockHttpClient
              .get(Uri.parse('https://www.dnd5eapi.co/api/features/frenzy')))
          .thenAnswer(
              (invocation) async => http.Response(subclassFeature, 200));

      final featuresForClassJson = await container
          .read(dndApiRepository)
          .getSubclassFeatures("berserker");
      expect(featuresForClassJson, isList);
    });
  });
}

const allRaces = '''
{
	"count": 9,
	"results": [
		{
			"index": "dragonborn",
			"name": "Dragonborn",
			"url": "/api/races/dragonborn"
		},
		{
			"index": "dwarf",
			"name": "Dwarf",
			"url": "/api/races/dwarf"
		},
		{
			"index": "elf",
			"name": "Elf",
			"url": "/api/races/elf"
		},
		{
			"index": "gnome",
			"name": "Gnome",
			"url": "/api/races/gnome"
		},
		{
			"index": "half-elf",
			"name": "Half-Elf",
			"url": "/api/races/half-elf"
		},
		{
			"index": "half-orc",
			"name": "Half-Orc",
			"url": "/api/races/half-orc"
		},
		{
			"index": "halfling",
			"name": "Halfling",
			"url": "/api/races/halfling"
		},
		{
			"index": "human",
			"name": "Human",
			"url": "/api/races/human"
		},
		{
			"index": "tiefling",
			"name": "Tiefling",
			"url": "/api/races/tiefling"
		}
	]
}
''';
const singleRace = '''
{
	"index": "elf",
	"name": "Elf",
	"speed": 30,
	"ability_bonuses": [
		{
			"ability_score": {
				"index": "dex",
				"name": "DEX",
				"url": "/api/ability-scores/dex"
			},
			"bonus": 2
		}
	],
	"age": "Although elves reach physical maturity at about the same age as humans, the elven understanding of adulthood goes beyond physical growth to encompass worldly experience. An elf typically claims adulthood and an adult name around the age of 100 and can live to be 750 years old.",
	"alignment": "Elves love freedom, variety, and self-expression, so they lean strongly toward the gentler aspects of chaos. They value and protect others' freedom as well as their own, and they are more often good than not.",
	"size": "Medium",
	"size_description": "Elves range from under 5 to over 6 feet tall and have slender builds. Your size is Medium.",
	"starting_proficiencies": [
		{
			"index": "skill-perception",
			"name": "Skill: Perception",
			"url": "/api/proficiencies/skill-perception"
		}
	],
	"languages": [
		{
			"index": "common",
			"name": "Common",
			"url": "/api/languages/common"
		},
		{
			"index": "elvish",
			"name": "Elvish",
			"url": "/api/languages/elvish"
		}
	],
	"language_desc": "You can speak, read, and write Common and Elvish. Elvish is fluid, with subtle intonations and intricate grammar. Elven literature is rich and varied, and their songs and poems are famous among other races. Many bards learn their language so they can add Elvish ballads to their repertoires.",
	"traits": [
		{
			"index": "darkvision",
			"name": "Darkvision",
			"url": "/api/traits/darkvision"
		},
		{
			"index": "fey-ancestry",
			"name": "Fey Ancestry",
			"url": "/api/traits/fey-ancestry"
		},
		{
			"index": "trance",
			"name": "Trance",
			"url": "/api/traits/trance"
		},
		{
			"index": "keen-senses",
			"name": "Keen Senses",
			"url": "/api/traits/keen-senses"
		}
	],
	"subraces": [
		{
			"index": "high-elf",
			"name": "High Elf",
			"url": "/api/subraces/high-elf"
		}
	],
	"url": "/api/races/elf"
}
''';
const singleSubrace = '''
{
	"index": "high-elf",
	"name": "High Elf",
	"race": {
		"index": "elf",
		"name": "Elf",
		"url": "/api/races/elf"
	},
	"desc": "As a high elf, you have a keen mind and a mastery of at least the basics of magic. In many fantasy gaming worlds, there are two kinds of high elves. One type is haughty and reclusive, believing themselves to be superior to non-elves and even other elves. The other type is more common and more friendly, and often encountered among humans and other races.",
	"ability_bonuses": [
		{
			"ability_score": {
				"index": "int",
				"name": "INT",
				"url": "/api/ability-scores/int"
			},
			"bonus": 1
		}
	],
	"starting_proficiencies": [
		{
			"index": "longswords",
			"name": "Longswords",
			"url": "/api/proficiencies/longswords"
		},
		{
			"index": "shortswords",
			"name": "Shortswords",
			"url": "/api/proficiencies/shortswords"
		},
		{
			"index": "shortbows",
			"name": "Shortbows",
			"url": "/api/proficiencies/shortbows"
		},
		{
			"index": "longbows",
			"name": "Longbows",
			"url": "/api/proficiencies/longbows"
		}
	],
	"languages": [],
	"language_options": {
		"choose": 1,
		"from": {
			"option_set_type": "options_array",
			"options": [
				{
					"option_type": "reference",
					"item": {
						"index": "dwarvish",
						"name": "Dwarvish",
						"url": "/api/languages/dwarvish"
					}
				},
				{
					"option_type": "reference",
					"item": {
						"index": "giant",
						"name": "Giant",
						"url": "/api/languages/giant"
					}
				},
				{
					"option_type": "reference",
					"item": {
						"index": "gnomish",
						"name": "Gnomish",
						"url": "/api/languages/gnomish"
					}
				},
				{
					"option_type": "reference",
					"item": {
						"index": "goblin",
						"name": "Goblin",
						"url": "/api/languages/goblin"
					}
				},
				{
					"option_type": "reference",
					"item": {
						"index": "halfling",
						"name": "Halfling",
						"url": "/api/languages/halfling"
					}
				},
				{
					"option_type": "reference",
					"item": {
						"index": "orc",
						"name": "Orc",
						"url": "/api/languages/orc"
					}
				},
				{
					"option_type": "reference",
					"item": {
						"index": "abyssal",
						"name": "Abyssal",
						"url": "/api/languages/abyssal"
					}
				},
				{
					"option_type": "reference",
					"item": {
						"index": "celestial",
						"name": "Celestial",
						"url": "/api/languages/celestial"
					}
				},
				{
					"option_type": "reference",
					"item": {
						"index": "draconic",
						"name": "Draconic",
						"url": "/api/languages/draconic"
					}
				},
				{
					"option_type": "reference",
					"item": {
						"index": "deep-speech",
						"name": "Deep Speech",
						"url": "/api/languages/deep-speech"
					}
				},
				{
					"option_type": "reference",
					"item": {
						"index": "infernal",
						"name": "Infernal",
						"url": "/api/languages/infernal"
					}
				},
				{
					"option_type": "reference",
					"item": {
						"index": "primordial",
						"name": "Primordial",
						"url": "/api/languages/primordial"
					}
				},
				{
					"option_type": "reference",
					"item": {
						"index": "sylvan",
						"name": "Sylvan",
						"url": "/api/languages/sylvan"
					}
				},
				{
					"option_type": "reference",
					"item": {
						"index": "undercommon",
						"name": "Undercommon",
						"url": "/api/languages/undercommon"
					}
				}
			]
		},
		"type": "language"
	},
	"racial_traits": [
		{
			"index": "elf-weapon-training",
			"name": "Elf Weapon Training",
			"url": "/api/traits/elf-weapon-training"
		},
		{
			"index": "high-elf-cantrip",
			"name": "High Elf Cantrip",
			"url": "/api/traits/high-elf-cantrip"
		},
		{
			"index": "extra-language",
			"name": "Extra Language",
			"url": "/api/traits/extra-language"
		}
	],
	"url": "/api/subraces/high-elf"
}
''';
const allClasses = '''
{
	"count": 12,
	"results": [
		{
			"index": "barbarian",
			"name": "Barbarian",
			"url": "/api/classes/barbarian"
		},
		{
			"index": "bard",
			"name": "Bard",
			"url": "/api/classes/bard"
		},
		{
			"index": "cleric",
			"name": "Cleric",
			"url": "/api/classes/cleric"
		},
		{
			"index": "druid",
			"name": "Druid",
			"url": "/api/classes/druid"
		},
		{
			"index": "fighter",
			"name": "Fighter",
			"url": "/api/classes/fighter"
		},
		{
			"index": "monk",
			"name": "Monk",
			"url": "/api/classes/monk"
		},
		{
			"index": "paladin",
			"name": "Paladin",
			"url": "/api/classes/paladin"
		},
		{
			"index": "ranger",
			"name": "Ranger",
			"url": "/api/classes/ranger"
		},
		{
			"index": "rogue",
			"name": "Rogue",
			"url": "/api/classes/rogue"
		},
		{
			"index": "sorcerer",
			"name": "Sorcerer",
			"url": "/api/classes/sorcerer"
		},
		{
			"index": "warlock",
			"name": "Warlock",
			"url": "/api/classes/warlock"
		},
		{
			"index": "wizard",
			"name": "Wizard",
			"url": "/api/classes/wizard"
		}
	]
}
''';
const singleClass = '''
{
	"index": "barbarian",
	"name": "Barbarian",
	"hit_die": 12,
	"proficiency_choices": [
		{
			"desc": "Choose two from Animal Handling, Athletics, Intimidation, Nature, Perception, and Survival",
			"choose": 2,
			"type": "proficiencies",
			"from": {
				"option_set_type": "options_array",
				"options": [
					{
						"option_type": "reference",
						"item": {
							"index": "skill-animal-handling",
							"name": "Skill: Animal Handling",
							"url": "/api/proficiencies/skill-animal-handling"
						}
					},
					{
						"option_type": "reference",
						"item": {
							"index": "skill-athletics",
							"name": "Skill: Athletics",
							"url": "/api/proficiencies/skill-athletics"
						}
					},
					{
						"option_type": "reference",
						"item": {
							"index": "skill-intimidation",
							"name": "Skill: Intimidation",
							"url": "/api/proficiencies/skill-intimidation"
						}
					},
					{
						"option_type": "reference",
						"item": {
							"index": "skill-nature",
							"name": "Skill: Nature",
							"url": "/api/proficiencies/skill-nature"
						}
					},
					{
						"option_type": "reference",
						"item": {
							"index": "skill-perception",
							"name": "Skill: Perception",
							"url": "/api/proficiencies/skill-perception"
						}
					},
					{
						"option_type": "reference",
						"item": {
							"index": "skill-survival",
							"name": "Skill: Survival",
							"url": "/api/proficiencies/skill-survival"
						}
					}
				]
			}
		}
	],
	"proficiencies": [
		{
			"index": "light-armor",
			"name": "Light Armor",
			"url": "/api/proficiencies/light-armor"
		},
		{
			"index": "medium-armor",
			"name": "Medium Armor",
			"url": "/api/proficiencies/medium-armor"
		},
		{
			"index": "shields",
			"name": "Shields",
			"url": "/api/proficiencies/shields"
		},
		{
			"index": "simple-weapons",
			"name": "Simple Weapons",
			"url": "/api/proficiencies/simple-weapons"
		},
		{
			"index": "martial-weapons",
			"name": "Martial Weapons",
			"url": "/api/proficiencies/martial-weapons"
		},
		{
			"index": "saving-throw-str",
			"name": "Saving Throw: STR",
			"url": "/api/proficiencies/saving-throw-str"
		},
		{
			"index": "saving-throw-con",
			"name": "Saving Throw: CON",
			"url": "/api/proficiencies/saving-throw-con"
		}
	],
	"saving_throws": [
		{
			"index": "str",
			"name": "STR",
			"url": "/api/ability-scores/str"
		},
		{
			"index": "con",
			"name": "CON",
			"url": "/api/ability-scores/con"
		}
	],
	"starting_equipment": [
		{
			"equipment": {
				"index": "explorers-pack",
				"name": "Explorer's Pack",
				"url": "/api/equipment/explorers-pack"
			},
			"quantity": 1
		},
		{
			"equipment": {
				"index": "javelin",
				"name": "Javelin",
				"url": "/api/equipment/javelin"
			},
			"quantity": 4
		}
	],
	"starting_equipment_options": [
		{
			"desc": "(a) a greataxe or (b) any martial melee weapon",
			"choose": 1,
			"type": "equipment",
			"from": {
				"option_set_type": "options_array",
				"options": [
					{
						"option_type": "counted_reference",
						"count": 1,
						"of": {
							"index": "greataxe",
							"name": "Greataxe",
							"url": "/api/equipment/greataxe"
						}
					},
					{
						"option_type": "choice",
						"choice": {
							"desc": "any martial melee weapon",
							"choose": 1,
							"type": "equipment",
							"from": {
								"option_set_type": "equipment_category",
								"equipment_category": {
									"index": "martial-melee-weapons",
									"name": "Martial Melee Weapons",
									"url": "/api/equipment-categories/martial-melee-weapons"
								}
							}
						}
					}
				]
			}
		},
		{
			"desc": "(a) two handaxes or (b) any simple weapon",
			"choose": 1,
			"type": "equipment",
			"from": {
				"option_set_type": "options_array",
				"options": [
					{
						"option_type": "counted_reference",
						"count": 2,
						"of": {
							"index": "handaxe",
							"name": "Handaxe",
							"url": "/api/equipment/handaxe"
						}
					},
					{
						"option_type": "choice",
						"choice": {
							"desc": "any simple weapon",
							"choose": 1,
							"type": "equipment",
							"from": {
								"option_set_type": "equipment_category",
								"equipment_category": {
									"index": "simple-weapons",
									"name": "Simple Weapons",
									"url": "/api/equipment-categories/simple-weapons"
								}
							}
						}
					}
				]
			}
		}
	],
	"class_levels": "/api/classes/barbarian/levels",
	"multi_classing": {
		"prerequisites": [
			{
				"ability_score": {
					"index": "str",
					"name": "STR",
					"url": "/api/ability-scores/str"
				},
				"minimum_score": 13
			}
		],
		"proficiencies": [
			{
				"index": "shields",
				"name": "Shields",
				"url": "/api/proficiencies/shields"
			},
			{
				"index": "simple-weapons",
				"name": "Simple Weapons",
				"url": "/api/proficiencies/simple-weapons"
			},
			{
				"index": "martial-weapons",
				"name": "Martial Weapons",
				"url": "/api/proficiencies/martial-weapons"
			}
		]
	},
	"subclasses": [
		{
			"index": "berserker",
			"name": "Berserker",
			"url": "/api/subclasses/berserker"
		}
	],
	"url": "/api/classes/barbarian"
}
''';
const singleSubclass = '''
{
	"index": "berserker",
	"class": {
		"index": "barbarian",
		"name": "Barbarian",
		"url": "/api/classes/barbarian"
	},
	"name": "Berserker",
	"subclass_flavor": "Primal Path",
	"desc": [
		"For some barbarians, rage is a means to an end--that end being violence. The Path of the Berserker is a path of untrammeled fury, slick with blood. As you enter the berserker's rage, you thrill in the chaos of battle, heedless of your own health or well-being."
	],
	"subclass_levels": "/api/subclasses/berserker/levels",
	"url": "/api/subclasses/berserker",
	"spells": []
}

''';
const allBackgrounds = '''
{
	"count": 1,
	"results": [
		{
			"index": "acolyte",
			"name": "Acolyte",
			"url": "/api/backgrounds/acolyte"
		}
	]
}
''';
const singleBackground = '''
{
	"index": "acolyte",
	"name": "Acolyte",
	"starting_proficiencies": [
		{
			"index": "skill-insight",
			"name": "Skill: Insight",
			"url": "/api/proficiencies/skill-insight"
		},
		{
			"index": "skill-religion",
			"name": "Skill: Religion",
			"url": "/api/proficiencies/skill-religion"
		}
	],
	"language_options": {
		"choose": 2,
		"type": "languages",
		"from": {
			"option_set_type": "resource_list",
			"resource_list_url": "/api/languages"
		}
	},
	"starting_equipment": [
		{
			"equipment": {
				"index": "clothes-common",
				"name": "Clothes, common",
				"url": "/api/equipment/clothes-common"
			},
			"quantity": 1
		},
		{
			"equipment": {
				"index": "pouch",
				"name": "Pouch",
				"url": "/api/equipment/pouch"
			},
			"quantity": 1
		}
	],
	"starting_equipment_options": [
		{
			"choose": 1,
			"type": "equipment",
			"from": {
				"option_set_type": "equipment_category",
				"equipment_category": {
					"index": "holy-symbols",
					"name": "Holy Symbols",
					"url": "/api/equipment-categories/holy-symbols"
				}
			}
		}
	],
	"feature": {
		"name": "Shelter of the Faithful",
		"desc": [
			"As an acolyte, you command the respect of those who share your faith, and you can perform the religious ceremonies of your deity. You and your adventuring companions can expect to receive free healing and care at a temple, shrine, or other established presence of your faith, though you must provide any material components needed for spells. Those who share your religion will support you (but only you) at a modest lifestyle.",
			"You might also have ties to a specific temple dedicated to your chosen deity or pantheon, and you have a residence there. This could be the temple where you used to serve, if you remain on good terms with it, or a temple where you have found a new home. While near your temple, you can call upon the priests for assistance, provided the assistance you ask for is not hazardous and you remain in good standing with your temple."
		]
	},
	"personality_traits": {
		"choose": 2,
		"type": "personality_traits",
		"from": {
			"option_set_type": "options_array",
			"options": [
				{
					"option_type": "string",
					"string": "I idolize a particular hero of my faith, and constantly refer to that person's deeds and example."
				},
				{
					"option_type": "string",
					"string": "I can find common ground between the fiercest enemies, empathizing with them and always working toward peace."
				},
				{
					"option_type": "string",
					"string": "I see omens in every event and action. The gods try to speak to us, we just need to listen."
				},
				{
					"option_type": "string",
					"string": "Nothing can shake my optimistic attitude."
				},
				{
					"option_type": "string",
					"string": "I quote (or misquote) sacred texts and proverbs in almost every situation."
				},
				{
					"option_type": "string",
					"string": "I am tolerant (or intolerant) of other faiths and respect (or condemn) the worship of other gods."
				},
				{
					"option_type": "string",
					"string": "I've enjoyed fine food, drink, and high society among my temple's elite. Rough living grates on me."
				},
				{
					"option_type": "string",
					"string": "I've spent so long in the temple that I have little practical experience dealing with people in the outside world."
				}
			]
		}
	},
	"ideals": {
		"choose": 1,
		"type": "ideals",
		"from": {
			"option_set_type": "options_array",
			"options": [
				{
					"option_type": "ideal",
					"desc": "Tradition. The ancient traditions of worship and sacrifice must be preserved and upheld.",
					"alignments": [
						{
							"index": "lawful-good",
							"name": "Lawful Good",
							"url": "/api/alignments/lawful-good"
						},
						{
							"index": "lawful-neutral",
							"name": "Lawful Neutral",
							"url": "/api/alignments/lawful-neutral"
						},
						{
							"index": "lawful-evil",
							"name": "Lawful Evil",
							"url": "/api/alignments/lawful-evil"
						}
					]
				},
				{
					"option_type": "ideal",
					"desc": "Charity. I always try to help those in need, no matter what the personal cost.",
					"alignments": [
						{
							"index": "lawful-good",
							"name": "Lawful Good",
							"url": "/api/alignments/lawful-good"
						},
						{
							"index": "neutral-good",
							"name": "Neutral Good",
							"url": "/api/alignments/neutral-good"
						},
						{
							"index": "chaotic-good",
							"name": "Chaotic Good",
							"url": "/api/alignments/chaotic-good"
						}
					]
				},
				{
					"option_type": "ideal",
					"desc": "Change. We must help bring about the changes the gods are constantly working in the world.",
					"alignments": [
						{
							"index": "chaotic-good",
							"name": "Chaotic Good",
							"url": "/api/alignments/chaotic-good"
						},
						{
							"index": "chaotic-neutral",
							"name": "Chaotic Neutral",
							"url": "/api/alignments/chaotic-neutral"
						},
						{
							"index": "chaotic-evil",
							"name": "Chaotic Evil",
							"url": "/api/alignments/chaotic-evil"
						}
					]
				},
				{
					"option_type": "ideal",
					"desc": "Power. I hope to one day rise to the top of my faith's religious hierarchy.",
					"alignments": [
						{
							"index": "lawful-good",
							"name": "Lawful Good",
							"url": "/api/alignments/lawful-good"
						},
						{
							"index": "lawful-neutral",
							"name": "Lawful Neutral",
							"url": "/api/alignments/lawful-neutral"
						},
						{
							"index": "lawful-evil",
							"name": "Lawful Evil",
							"url": "/api/alignments/lawful-evil"
						}
					]
				},
				{
					"option_type": "ideal",
					"desc": "Faith. I trust that my deity will guide my actions. I have faith that if I work hard, things will go well.",
					"alignments": [
						{
							"index": "lawful-good",
							"name": "Lawful Good",
							"url": "/api/alignments/lawful-good"
						},
						{
							"index": "lawful-neutral",
							"name": "Lawful Neutral",
							"url": "/api/alignments/lawful-neutral"
						},
						{
							"index": "lawful-evil",
							"name": "Lawful Evil",
							"url": "/api/alignments/lawful-evil"
						}
					]
				},
				{
					"option_type": "ideal",
					"desc": "Aspiration. I seek to prove myself worthy of my god's favor by matching my actions against his or her teachings.",
					"alignments": [
						{
							"index": "lawful-good",
							"name": "Lawful Good",
							"url": "/api/alignments/lawful-good"
						},
						{
							"index": "neutral-good",
							"name": "Neutral Good",
							"url": "/api/alignments/neutral-good"
						},
						{
							"index": "chaotic-good",
							"name": "Chaotic Good",
							"url": "/api/alignments/chaotic-good"
						},
						{
							"index": "lawful-neutral",
							"name": "Lawful Neutral",
							"url": "/api/alignments/lawful-neutral"
						},
						{
							"index": "neutral",
							"name": "Neutral",
							"url": "/api/alignments/neutral"
						},
						{
							"index": "chaotic-neutral",
							"name": "Chaotic Neutral",
							"url": "/api/alignments/chaotic-neutral"
						},
						{
							"index": "lawful-evil",
							"name": "Lawful Evil",
							"url": "/api/alignments/lawful-evil"
						},
						{
							"index": "neutral-evil",
							"name": "Neutral Evil",
							"url": "/api/alignments/neutral-evil"
						},
						{
							"index": "chaotic-evil",
							"name": "Chaotic Evil",
							"url": "/api/alignments/chaotic-evil"
						}
					]
				}
			]
		}
	},
	"bonds": {
		"choose": 1,
		"type": "bonds",
		"from": {
			"option_set_type": "options_array",
			"options": [
				{
					"option_type": "string",
					"string": "I would die to recover an ancient relic of my faith that was lost long ago."
				},
				{
					"option_type": "string",
					"string": "I will someday get revenge on the corrupt temple hierarchy who branded me a heretic."
				},
				{
					"option_type": "string",
					"string": "I owe my life to the priest who took me in when my parents died."
				},
				{
					"option_type": "string",
					"string": "Everything I do is for the common people."
				},
				{
					"option_type": "string",
					"string": "I will do anything to protect the temple where I served."
				},
				{
					"option_type": "string",
					"string": "I seek to preserve a sacred text that my enemies consider heretical and seek to destroy."
				}
			]
		}
	},
	"flaws": {
		"choose": 1,
		"type": "flaws",
		"from": {
			"option_set_type": "options_array",
			"options": [
				{
					"option_type": "string",
					"string": "I judge others harshly, and myself even more severely."
				},
				{
					"option_type": "string",
					"string": "I put too much trust in those who wield power within my temple's hierarchy."
				},
				{
					"option_type": "string",
					"string": "My piety sometimes leads me to blindly trust those that profess faith in my god."
				},
				{
					"option_type": "string",
					"string": "I am inflexible in my thinking."
				},
				{
					"option_type": "string",
					"string": "I am suspicious of strangers and expect the worst of them."
				},
				{
					"option_type": "string",
					"string": "Once I pick a goal, I become obsessed with it to the detriment of everything else in my life."
				}
			]
		}
	},
	"url": "/api/backgrounds/acolyte"
}

''';
const allLanguages = '''
{
	"count": 16,
	"results": [
		{
			"index": "abyssal",
			"name": "Abyssal",
			"url": "/api/languages/abyssal"
		},
		{
			"index": "celestial",
			"name": "Celestial",
			"url": "/api/languages/celestial"
		},
		{
			"index": "common",
			"name": "Common",
			"url": "/api/languages/common"
		},
		{
			"index": "deep-speech",
			"name": "Deep Speech",
			"url": "/api/languages/deep-speech"
		},
		{
			"index": "draconic",
			"name": "Draconic",
			"url": "/api/languages/draconic"
		},
		{
			"index": "dwarvish",
			"name": "Dwarvish",
			"url": "/api/languages/dwarvish"
		},
		{
			"index": "elvish",
			"name": "Elvish",
			"url": "/api/languages/elvish"
		},
		{
			"index": "giant",
			"name": "Giant",
			"url": "/api/languages/giant"
		},
		{
			"index": "gnomish",
			"name": "Gnomish",
			"url": "/api/languages/gnomish"
		},
		{
			"index": "goblin",
			"name": "Goblin",
			"url": "/api/languages/goblin"
		},
		{
			"index": "halfling",
			"name": "Halfling",
			"url": "/api/languages/halfling"
		},
		{
			"index": "infernal",
			"name": "Infernal",
			"url": "/api/languages/infernal"
		},
		{
			"index": "orc",
			"name": "Orc",
			"url": "/api/languages/orc"
		},
		{
			"index": "primordial",
			"name": "Primordial",
			"url": "/api/languages/primordial"
		},
		{
			"index": "sylvan",
			"name": "Sylvan",
			"url": "/api/languages/sylvan"
		},
		{
			"index": "undercommon",
			"name": "Undercommon",
			"url": "/api/languages/undercommon"
		}
	]
}
''';
const spellsForClass = '''
{
	"count": 204,
	"results": [
		{
			"index": "acid-splash",
			"name": "Acid Splash",
			"url": "/api/spells/acid-splash"
		}
	]
}
''';

const acidSplashSpell = '''
{
	"higher_level": [],
	"index": "acid-splash",
	"name": "Acid Splash",
	"desc": [
		"You hurl a bubble of acid. Choose one creature within range, or choose two creatures within range that are within 5 feet of each other. A target must succeed on a dexterity saving throw or take 1d6 acid damage.",
		"This spell's damage increases by 1d6 when you reach 5th level (2d6), 11th level (3d6), and 17th level (4d6)."
	],
	"range": "60 feet",
	"components": [
		"V",
		"S"
	],
	"ritual": false,
	"duration": "Instantaneous",
	"concentration": false,
	"casting_time": "1 action",
	"level": 0,
	"damage": {
		"damage_type": {
			"index": "acid",
			"name": "Acid",
			"url": "/api/damage-types/acid"
		},
		"damage_at_character_level": {
			"1": "1d6",
			"5": "2d6",
			"11": "3d6",
			"17": "4d6"
		}
	},
	"dc": {
		"dc_type": {
			"index": "dex",
			"name": "DEX",
			"url": "/api/ability-scores/dex"
		},
		"dc_success": "none"
	},
	"school": {
		"index": "conjuration",
		"name": "Conjuration",
		"url": "/api/magic-schools/conjuration"
	},
	"classes": [
		{
			"index": "sorcerer",
			"name": "Sorcerer",
			"url": "/api/classes/sorcerer"
		},
		{
			"index": "wizard",
			"name": "Wizard",
			"url": "/api/classes/wizard"
		}
	],
	"subclasses": [
		{
			"index": "lore",
			"name": "Lore",
			"url": "/api/subclasses/lore"
		}
	],
	"url": "/api/spells/acid-splash"
}
''';

const levelsForClass = '''
[
	{
		"level": 1,
		"ability_score_bonuses": 0,
		"prof_bonus": 2,
		"features": [
			{
				"index": "rage",
				"name": "Rage",
				"url": "/api/features/rage"
			}
		],
		"class_specific": {
			"rage_count": 2,
			"rage_damage_bonus": 2,
			"brutal_critical_dice": 0
		},
		"index": "barbarian-1",
		"class": {
			"index": "barbarian",
			"name": "Barbarian",
			"url": "/api/classes/barbarian"
		},
		"url": "/api/classes/barbarian/levels/1"
	}
]
''';

const classFeature = '''
{
	"index": "rage",
	"class": {
		"index": "barbarian",
		"name": "Barbarian",
		"url": "/api/classes/barbarian"
	},
	"name": "Rage",
	"level": 1,
	"prerequisites": [],
	"desc": [
		"In battle, you fight with primal ferocity. On your turn, you can enter a rage as a bonus action. While raging, you gain the following benefits if you aren't wearing heavy armor:",
		"- You have advantage on Strength checks and Strength saving throws.",
		"- When you make a melee weapon Attack using Strength, you gain a +2 bonus to the damage roll. This bonus increases as you level.",
		"- You have Resistance to bludgeoning, piercing, and slashing damage.",
		"If you are able to cast Spells, you can't cast them or concentrate on them while raging.",
		"Your rage lasts for 1 minute. It ends early if you are knocked Unconscious or if Your Turn ends and you haven't attacked a hostile creature since your last turn or taken damage since then. You can also end your rage on Your Turn as a Bonus Action.",
		"Once you have raged the maximum number of times for your barbarian level, you must finish a Long Rest before you can rage again. You may rage 2 times at 1st level, 3 at 3rd, 4 at 6th, 5 at 12th, and 6 at 17th."
	],
	"url": "/api/features/rage"
}
''';

const levelsForSubclass = '''
[
	{
		"level": 3,
		"features": [
			{
				"index": "frenzy",
				"name": "Frenzy",
				"url": "/api/features/frenzy"
			}
		],
		"class": {
			"index": "barbarian",
			"name": "Barbarian",
			"url": "/api/classes/barbarian"
		},
		"subclass": {
			"index": "berserker",
			"name": "Berserker",
			"url": "/api/subclasses/berserker"
		},
		"url": "/api/subclasses/berserker/levels/3",
		"index": "berserker-3"
	}
]
''';

const subclassFeature = '''
{
	"index": "frenzy",
	"class": {
		"index": "barbarian",
		"name": "Barbarian",
		"url": "/api/classes/barbarian"
	},
	"subclass": {
		"index": "berserker",
		"name": "Berserker",
		"url": "/api/subclasses/berserker"
	},
	"name": "Frenzy",
	"level": 3,
	"prerequisites": [],
	"desc": [
		"Starting when you choose this path at 3rd level, you can go into a frenzy when you rage. If you do so, for the duration of your rage you can make a single melee weapon attack as a bonus action on each of your turns after this one. When your rage ends, you suffer one level of exhaustion (as described in appendix A)."
	],
	"url": "/api/features/frenzy"
}

''';
