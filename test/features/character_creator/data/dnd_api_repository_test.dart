import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:mythos_manager/features/character_creator/data/dnd_api_repository.dart';

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

      final singleRaceJson = await container.read(dndApiRepository).getRace('elf');
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

      final singleSubraceJson = await container.read(dndApiRepository).getSubrace("high-elf");
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

      final allClassesJson = await container.read(dndApiRepository).getAllClasses();
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

      final singleClassJson = await container.read(dndApiRepository).getClass("barbarian");
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

      when(() => mockHttpClient
          .get(Uri.parse('https://www.dnd5eapi.co/api/subclasses/berserker')))
          .thenAnswer((invocation) async => http.Response(singleSubclass, 200));

      final singleSubclassJson = await container.read(dndApiRepository).getSubclass("berserker");
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

      final allBackgroundsJson = await container.read(dndApiRepository).getAllBackgrounds();
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

      when(() => mockHttpClient
          .get(Uri.parse('https://www.dnd5eapi.co/api/backgrounds/acolyte')))
          .thenAnswer((invocation) async => http.Response(singleBackground, 200));

      final singleBackgroundJson = await container.read(dndApiRepository).getBackground("acolyte");
      expect(singleBackgroundJson, isMap);
      expect(singleBackgroundJson.containsKey("index"), isTrue);
      expect(singleBackgroundJson.containsKey("name"), isTrue);
      expect(singleBackgroundJson.containsKey("starting_proficiencies"), isTrue);
      expect(singleBackgroundJson.containsKey("language_options"), isTrue);
      expect(singleBackgroundJson.containsKey("starting_equipment"), isTrue);
      expect(singleBackgroundJson.containsKey("starting_equipment_options"), isTrue);
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

      final allLanguagesJson = await container.read(dndApiRepository).getAllLanguages();
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

      when(() => mockHttpClient
          .get(Uri.parse('https://www.dnd5eapi.co/api/classes/wizard/spells')))
          .thenAnswer((invocation) async => http.Response(spellsForClass, 200));

      final spellsForClassJson = await container.read(dndApiRepository).getSpellsForClass("wizard");
      expect(spellsForClassJson, isMap);
      expect(spellsForClassJson["count"], 204);
      expect(spellsForClassJson["results"], isList);
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
		},
		{
			"index": "chill-touch",
			"name": "Chill Touch",
			"url": "/api/spells/chill-touch"
		},
		{
			"index": "dancing-lights",
			"name": "Dancing Lights",
			"url": "/api/spells/dancing-lights"
		},
		{
			"index": "fire-bolt",
			"name": "Fire Bolt",
			"url": "/api/spells/fire-bolt"
		},
		{
			"index": "light",
			"name": "Light",
			"url": "/api/spells/light"
		},
		{
			"index": "mage-hand",
			"name": "Mage Hand",
			"url": "/api/spells/mage-hand"
		},
		{
			"index": "mending",
			"name": "Mending",
			"url": "/api/spells/mending"
		},
		{
			"index": "message",
			"name": "Message",
			"url": "/api/spells/message"
		},
		{
			"index": "minor-illusion",
			"name": "Minor Illusion",
			"url": "/api/spells/minor-illusion"
		},
		{
			"index": "poison-spray",
			"name": "Poison Spray",
			"url": "/api/spells/poison-spray"
		},
		{
			"index": "prestidigitation",
			"name": "Prestidigitation",
			"url": "/api/spells/prestidigitation"
		},
		{
			"index": "ray-of-frost",
			"name": "Ray of Frost",
			"url": "/api/spells/ray-of-frost"
		},
		{
			"index": "shocking-grasp",
			"name": "Shocking Grasp",
			"url": "/api/spells/shocking-grasp"
		},
		{
			"index": "true-strike",
			"name": "True Strike",
			"url": "/api/spells/true-strike"
		},
		{
			"index": "alarm",
			"name": "Alarm",
			"url": "/api/spells/alarm"
		},
		{
			"index": "burning-hands",
			"name": "Burning Hands",
			"url": "/api/spells/burning-hands"
		},
		{
			"index": "charm-person",
			"name": "Charm Person",
			"url": "/api/spells/charm-person"
		},
		{
			"index": "color-spray",
			"name": "Color Spray",
			"url": "/api/spells/color-spray"
		},
		{
			"index": "comprehend-languages",
			"name": "Comprehend Languages",
			"url": "/api/spells/comprehend-languages"
		},
		{
			"index": "detect-magic",
			"name": "Detect Magic",
			"url": "/api/spells/detect-magic"
		},
		{
			"index": "disguise-self",
			"name": "Disguise Self",
			"url": "/api/spells/disguise-self"
		},
		{
			"index": "expeditious-retreat",
			"name": "Expeditious Retreat",
			"url": "/api/spells/expeditious-retreat"
		},
		{
			"index": "false-life",
			"name": "False Life",
			"url": "/api/spells/false-life"
		},
		{
			"index": "feather-fall",
			"name": "Feather Fall",
			"url": "/api/spells/feather-fall"
		},
		{
			"index": "find-familiar",
			"name": "Find Familiar",
			"url": "/api/spells/find-familiar"
		},
		{
			"index": "floating-disk",
			"name": "Floating Disk",
			"url": "/api/spells/floating-disk"
		},
		{
			"index": "fog-cloud",
			"name": "Fog Cloud",
			"url": "/api/spells/fog-cloud"
		},
		{
			"index": "grease",
			"name": "Grease",
			"url": "/api/spells/grease"
		},
		{
			"index": "hideous-laughter",
			"name": "Hideous Laughter",
			"url": "/api/spells/hideous-laughter"
		},
		{
			"index": "identify",
			"name": "Identify",
			"url": "/api/spells/identify"
		},
		{
			"index": "illusory-script",
			"name": "Illusory Script",
			"url": "/api/spells/illusory-script"
		},
		{
			"index": "jump",
			"name": "Jump",
			"url": "/api/spells/jump"
		},
		{
			"index": "longstrider",
			"name": "Longstrider",
			"url": "/api/spells/longstrider"
		},
		{
			"index": "mage-armor",
			"name": "Mage Armor",
			"url": "/api/spells/mage-armor"
		},
		{
			"index": "magic-missile",
			"name": "Magic Missile",
			"url": "/api/spells/magic-missile"
		},
		{
			"index": "protection-from-evil-and-good",
			"name": "Protection from Evil and Good",
			"url": "/api/spells/protection-from-evil-and-good"
		},
		{
			"index": "shield",
			"name": "Shield",
			"url": "/api/spells/shield"
		},
		{
			"index": "silent-image",
			"name": "Silent Image",
			"url": "/api/spells/silent-image"
		},
		{
			"index": "sleep",
			"name": "Sleep",
			"url": "/api/spells/sleep"
		},
		{
			"index": "thunderwave",
			"name": "Thunderwave",
			"url": "/api/spells/thunderwave"
		},
		{
			"index": "unseen-servant",
			"name": "Unseen Servant",
			"url": "/api/spells/unseen-servant"
		},
		{
			"index": "acid-arrow",
			"name": "Acid Arrow",
			"url": "/api/spells/acid-arrow"
		},
		{
			"index": "alter-self",
			"name": "Alter Self",
			"url": "/api/spells/alter-self"
		},
		{
			"index": "arcane-lock",
			"name": "Arcane Lock",
			"url": "/api/spells/arcane-lock"
		},
		{
			"index": "arcanists-magic-aura",
			"name": "Arcanist's Magic Aura",
			"url": "/api/spells/arcanists-magic-aura"
		},
		{
			"index": "blindness-deafness",
			"name": "Blindness/Deafness",
			"url": "/api/spells/blindness-deafness"
		},
		{
			"index": "blur",
			"name": "Blur",
			"url": "/api/spells/blur"
		},
		{
			"index": "continual-flame",
			"name": "Continual Flame",
			"url": "/api/spells/continual-flame"
		},
		{
			"index": "darkness",
			"name": "Darkness",
			"url": "/api/spells/darkness"
		},
		{
			"index": "darkvision",
			"name": "Darkvision",
			"url": "/api/spells/darkvision"
		},
		{
			"index": "detect-thoughts",
			"name": "Detect Thoughts",
			"url": "/api/spells/detect-thoughts"
		},
		{
			"index": "enlarge-reduce",
			"name": "Enlarge/Reduce",
			"url": "/api/spells/enlarge-reduce"
		},
		{
			"index": "flaming-sphere",
			"name": "Flaming Sphere",
			"url": "/api/spells/flaming-sphere"
		},
		{
			"index": "gentle-repose",
			"name": "Gentle Repose",
			"url": "/api/spells/gentle-repose"
		},
		{
			"index": "gust-of-wind",
			"name": "Gust of Wind",
			"url": "/api/spells/gust-of-wind"
		},
		{
			"index": "hold-person",
			"name": "Hold Person",
			"url": "/api/spells/hold-person"
		},
		{
			"index": "invisibility",
			"name": "Invisibility",
			"url": "/api/spells/invisibility"
		},
		{
			"index": "knock",
			"name": "Knock",
			"url": "/api/spells/knock"
		},
		{
			"index": "levitate",
			"name": "Levitate",
			"url": "/api/spells/levitate"
		},
		{
			"index": "locate-object",
			"name": "Locate Object",
			"url": "/api/spells/locate-object"
		},
		{
			"index": "magic-mouth",
			"name": "Magic Mouth",
			"url": "/api/spells/magic-mouth"
		},
		{
			"index": "magic-weapon",
			"name": "Magic Weapon",
			"url": "/api/spells/magic-weapon"
		},
		{
			"index": "mirror-image",
			"name": "Mirror Image",
			"url": "/api/spells/mirror-image"
		},
		{
			"index": "misty-step",
			"name": "Misty Step",
			"url": "/api/spells/misty-step"
		},
		{
			"index": "ray-of-enfeeblement",
			"name": "Ray of Enfeeblement",
			"url": "/api/spells/ray-of-enfeeblement"
		},
		{
			"index": "rope-trick",
			"name": "Rope Trick",
			"url": "/api/spells/rope-trick"
		},
		{
			"index": "scorching-ray",
			"name": "Scorching Ray",
			"url": "/api/spells/scorching-ray"
		},
		{
			"index": "see-invisibility",
			"name": "See Invisibility",
			"url": "/api/spells/see-invisibility"
		},
		{
			"index": "shatter",
			"name": "Shatter",
			"url": "/api/spells/shatter"
		},
		{
			"index": "spider-climb",
			"name": "Spider Climb",
			"url": "/api/spells/spider-climb"
		},
		{
			"index": "suggestion",
			"name": "Suggestion",
			"url": "/api/spells/suggestion"
		},
		{
			"index": "web",
			"name": "Web",
			"url": "/api/spells/web"
		},
		{
			"index": "animate-dead",
			"name": "Animate Dead",
			"url": "/api/spells/animate-dead"
		},
		{
			"index": "bestow-curse",
			"name": "Bestow Curse",
			"url": "/api/spells/bestow-curse"
		},
		{
			"index": "blink",
			"name": "Blink",
			"url": "/api/spells/blink"
		},
		{
			"index": "clairvoyance",
			"name": "Clairvoyance",
			"url": "/api/spells/clairvoyance"
		},
		{
			"index": "counterspell",
			"name": "Counterspell",
			"url": "/api/spells/counterspell"
		},
		{
			"index": "dispel-magic",
			"name": "Dispel Magic",
			"url": "/api/spells/dispel-magic"
		},
		{
			"index": "fear",
			"name": "Fear",
			"url": "/api/spells/fear"
		},
		{
			"index": "fireball",
			"name": "Fireball",
			"url": "/api/spells/fireball"
		},
		{
			"index": "fly",
			"name": "Fly",
			"url": "/api/spells/fly"
		},
		{
			"index": "gaseous-form",
			"name": "Gaseous Form",
			"url": "/api/spells/gaseous-form"
		},
		{
			"index": "glyph-of-warding",
			"name": "Glyph of Warding",
			"url": "/api/spells/glyph-of-warding"
		},
		{
			"index": "haste",
			"name": "Haste",
			"url": "/api/spells/haste"
		},
		{
			"index": "hypnotic-pattern",
			"name": "Hypnotic Pattern",
			"url": "/api/spells/hypnotic-pattern"
		},
		{
			"index": "lightning-bolt",
			"name": "Lightning Bolt",
			"url": "/api/spells/lightning-bolt"
		},
		{
			"index": "magic-circle",
			"name": "Magic Circle",
			"url": "/api/spells/magic-circle"
		},
		{
			"index": "major-image",
			"name": "Major Image",
			"url": "/api/spells/major-image"
		},
		{
			"index": "nondetection",
			"name": "Nondetection",
			"url": "/api/spells/nondetection"
		},
		{
			"index": "phantom-steed",
			"name": "Phantom Steed",
			"url": "/api/spells/phantom-steed"
		},
		{
			"index": "protection-from-energy",
			"name": "Protection From Energy",
			"url": "/api/spells/protection-from-energy"
		},
		{
			"index": "remove-curse",
			"name": "Remove Curse",
			"url": "/api/spells/remove-curse"
		},
		{
			"index": "sending",
			"name": "Sending",
			"url": "/api/spells/sending"
		},
		{
			"index": "sleet-storm",
			"name": "Sleet Storm",
			"url": "/api/spells/sleet-storm"
		},
		{
			"index": "slow",
			"name": "Slow",
			"url": "/api/spells/slow"
		},
		{
			"index": "stinking-cloud",
			"name": "Stinking Cloud",
			"url": "/api/spells/stinking-cloud"
		},
		{
			"index": "tiny-hut",
			"name": "Tiny Hut",
			"url": "/api/spells/tiny-hut"
		},
		{
			"index": "tongues",
			"name": "Tongues",
			"url": "/api/spells/tongues"
		},
		{
			"index": "vampiric-touch",
			"name": "Vampiric Touch",
			"url": "/api/spells/vampiric-touch"
		},
		{
			"index": "water-breathing",
			"name": "Water Breathing",
			"url": "/api/spells/water-breathing"
		},
		{
			"index": "arcane-eye",
			"name": "Arcane Eye",
			"url": "/api/spells/arcane-eye"
		},
		{
			"index": "banishment",
			"name": "Banishment",
			"url": "/api/spells/banishment"
		},
		{
			"index": "black-tentacles",
			"name": "Black Tentacles",
			"url": "/api/spells/black-tentacles"
		},
		{
			"index": "blight",
			"name": "Blight",
			"url": "/api/spells/blight"
		},
		{
			"index": "confusion",
			"name": "Confusion",
			"url": "/api/spells/confusion"
		},
		{
			"index": "conjure-minor-elementals",
			"name": "Conjure Minor Elementals",
			"url": "/api/spells/conjure-minor-elementals"
		},
		{
			"index": "control-water",
			"name": "Control Water",
			"url": "/api/spells/control-water"
		},
		{
			"index": "dimension-door",
			"name": "Dimension Door",
			"url": "/api/spells/dimension-door"
		},
		{
			"index": "fabricate",
			"name": "Fabricate",
			"url": "/api/spells/fabricate"
		},
		{
			"index": "faithful-hound",
			"name": "Faithful Hound",
			"url": "/api/spells/faithful-hound"
		},
		{
			"index": "fire-shield",
			"name": "Fire Shield",
			"url": "/api/spells/fire-shield"
		},
		{
			"index": "greater-invisibility",
			"name": "Greater Invisibility",
			"url": "/api/spells/greater-invisibility"
		},
		{
			"index": "hallucinatory-terrain",
			"name": "Hallucinatory Terrain",
			"url": "/api/spells/hallucinatory-terrain"
		},
		{
			"index": "ice-storm",
			"name": "Ice Storm",
			"url": "/api/spells/ice-storm"
		},
		{
			"index": "locate-creature",
			"name": "Locate Creature",
			"url": "/api/spells/locate-creature"
		},
		{
			"index": "phantasmal-killer",
			"name": "Phantasmal Killer",
			"url": "/api/spells/phantasmal-killer"
		},
		{
			"index": "polymorph",
			"name": "Polymorph",
			"url": "/api/spells/polymorph"
		},
		{
			"index": "private-sanctum",
			"name": "Private Sanctum",
			"url": "/api/spells/private-sanctum"
		},
		{
			"index": "resilient-sphere",
			"name": "Resilient Sphere",
			"url": "/api/spells/resilient-sphere"
		},
		{
			"index": "secret-chest",
			"name": "Secret Chest",
			"url": "/api/spells/secret-chest"
		},
		{
			"index": "stone-shape",
			"name": "Stone Shape",
			"url": "/api/spells/stone-shape"
		},
		{
			"index": "stoneskin",
			"name": "Stoneskin",
			"url": "/api/spells/stoneskin"
		},
		{
			"index": "wall-of-fire",
			"name": "Wall of Fire",
			"url": "/api/spells/wall-of-fire"
		},
		{
			"index": "animate-objects",
			"name": "Animate Objects",
			"url": "/api/spells/animate-objects"
		},
		{
			"index": "arcane-hand",
			"name": "Arcane Hand",
			"url": "/api/spells/arcane-hand"
		},
		{
			"index": "cloudkill",
			"name": "Cloudkill",
			"url": "/api/spells/cloudkill"
		},
		{
			"index": "cone-of-cold",
			"name": "Cone of Cold",
			"url": "/api/spells/cone-of-cold"
		},
		{
			"index": "conjure-elemental",
			"name": "Conjure Elemental",
			"url": "/api/spells/conjure-elemental"
		},
		{
			"index": "contact-other-plane",
			"name": "Contact Other Plane",
			"url": "/api/spells/contact-other-plane"
		},
		{
			"index": "creation",
			"name": "Creation",
			"url": "/api/spells/creation"
		},
		{
			"index": "dominate-person",
			"name": "Dominate Person",
			"url": "/api/spells/dominate-person"
		},
		{
			"index": "dream",
			"name": "Dream",
			"url": "/api/spells/dream"
		},
		{
			"index": "geas",
			"name": "Geas",
			"url": "/api/spells/geas"
		},
		{
			"index": "hold-monster",
			"name": "Hold Monster",
			"url": "/api/spells/hold-monster"
		},
		{
			"index": "legend-lore",
			"name": "Legend Lore",
			"url": "/api/spells/legend-lore"
		},
		{
			"index": "mislead",
			"name": "Mislead",
			"url": "/api/spells/mislead"
		},
		{
			"index": "modify-memory",
			"name": "Modify Memory",
			"url": "/api/spells/modify-memory"
		},
		{
			"index": "passwall",
			"name": "Passwall",
			"url": "/api/spells/passwall"
		},
		{
			"index": "planar-binding",
			"name": "Planar Binding",
			"url": "/api/spells/planar-binding"
		},
		{
			"index": "scrying",
			"name": "Scrying",
			"url": "/api/spells/scrying"
		},
		{
			"index": "seeming",
			"name": "Seeming",
			"url": "/api/spells/seeming"
		},
		{
			"index": "telekinesis",
			"name": "Telekinesis",
			"url": "/api/spells/telekinesis"
		},
		{
			"index": "telepathic-bond",
			"name": "Telepathic Bond",
			"url": "/api/spells/telepathic-bond"
		},
		{
			"index": "teleportation-circle",
			"name": "Teleportation Circle",
			"url": "/api/spells/teleportation-circle"
		},
		{
			"index": "wall-of-force",
			"name": "Wall of Force",
			"url": "/api/spells/wall-of-force"
		},
		{
			"index": "wall-of-stone",
			"name": "Wall of Stone",
			"url": "/api/spells/wall-of-stone"
		},
		{
			"index": "chain-lightning",
			"name": "Chain Lightning",
			"url": "/api/spells/chain-lightning"
		},
		{
			"index": "circle-of-death",
			"name": "Circle of Death",
			"url": "/api/spells/circle-of-death"
		},
		{
			"index": "contingency",
			"name": "Contingency",
			"url": "/api/spells/contingency"
		},
		{
			"index": "create-undead",
			"name": "Create Undead",
			"url": "/api/spells/create-undead"
		},
		{
			"index": "disintegrate",
			"name": "Disintegrate",
			"url": "/api/spells/disintegrate"
		},
		{
			"index": "eyebite",
			"name": "Eyebite",
			"url": "/api/spells/eyebite"
		},
		{
			"index": "flesh-to-stone",
			"name": "Flesh to Stone",
			"url": "/api/spells/flesh-to-stone"
		},
		{
			"index": "freezing-sphere",
			"name": "Freezing Sphere",
			"url": "/api/spells/freezing-sphere"
		},
		{
			"index": "globe-of-invulnerability",
			"name": "Globe of Invulnerability",
			"url": "/api/spells/globe-of-invulnerability"
		},
		{
			"index": "guards-and-wards",
			"name": "Guards and Wards",
			"url": "/api/spells/guards-and-wards"
		},
		{
			"index": "instant-summons",
			"name": "Instant Summons",
			"url": "/api/spells/instant-summons"
		},
		{
			"index": "irresistible-dance",
			"name": "Irresistible Dance",
			"url": "/api/spells/irresistible-dance"
		},
		{
			"index": "magic-jar",
			"name": "Magic Jar",
			"url": "/api/spells/magic-jar"
		},
		{
			"index": "mass-suggestion",
			"name": "Mass Suggestion",
			"url": "/api/spells/mass-suggestion"
		},
		{
			"index": "move-earth",
			"name": "Move Earth",
			"url": "/api/spells/move-earth"
		},
		{
			"index": "programmed-illusion",
			"name": "Programmed Illusion",
			"url": "/api/spells/programmed-illusion"
		},
		{
			"index": "sunbeam",
			"name": "Sunbeam",
			"url": "/api/spells/sunbeam"
		},
		{
			"index": "true-seeing",
			"name": "True Seeing",
			"url": "/api/spells/true-seeing"
		},
		{
			"index": "wall-of-ice",
			"name": "Wall of Ice",
			"url": "/api/spells/wall-of-ice"
		},
		{
			"index": "arcane-sword",
			"name": "Arcane Sword",
			"url": "/api/spells/arcane-sword"
		},
		{
			"index": "delayed-blast-fireball",
			"name": "Delayed Blast Fireball",
			"url": "/api/spells/delayed-blast-fireball"
		},
		{
			"index": "etherealness",
			"name": "Etherealness",
			"url": "/api/spells/etherealness"
		},
		{
			"index": "finger-of-death",
			"name": "Finger of Death",
			"url": "/api/spells/finger-of-death"
		},
		{
			"index": "forcecage",
			"name": "Forcecage",
			"url": "/api/spells/forcecage"
		},
		{
			"index": "magnificent-mansion",
			"name": "Magnificent Mansion",
			"url": "/api/spells/magnificent-mansion"
		},
		{
			"index": "mirage-arcane",
			"name": "Mirage Arcane",
			"url": "/api/spells/mirage-arcane"
		},
		{
			"index": "plane-shift",
			"name": "Plane Shift",
			"url": "/api/spells/plane-shift"
		},
		{
			"index": "prismatic-spray",
			"name": "Prismatic Spray",
			"url": "/api/spells/prismatic-spray"
		},
		{
			"index": "project-image",
			"name": "Project Image",
			"url": "/api/spells/project-image"
		},
		{
			"index": "reverse-gravity",
			"name": "Reverse Gravity",
			"url": "/api/spells/reverse-gravity"
		},
		{
			"index": "sequester",
			"name": "Sequester",
			"url": "/api/spells/sequester"
		},
		{
			"index": "simulacrum",
			"name": "Simulacrum",
			"url": "/api/spells/simulacrum"
		},
		{
			"index": "symbol",
			"name": "Symbol",
			"url": "/api/spells/symbol"
		},
		{
			"index": "teleport",
			"name": "Teleport",
			"url": "/api/spells/teleport"
		},
		{
			"index": "antimagic-field",
			"name": "Antimagic Field",
			"url": "/api/spells/antimagic-field"
		},
		{
			"index": "antipathy-sympathy",
			"name": "Antipathy/Sympathy",
			"url": "/api/spells/antipathy-sympathy"
		},
		{
			"index": "clone",
			"name": "Clone",
			"url": "/api/spells/clone"
		},
		{
			"index": "control-weather",
			"name": "Control Weather",
			"url": "/api/spells/control-weather"
		},
		{
			"index": "demiplane",
			"name": "Demiplane",
			"url": "/api/spells/demiplane"
		},
		{
			"index": "dominate-monster",
			"name": "Dominate Monster",
			"url": "/api/spells/dominate-monster"
		},
		{
			"index": "feeblemind",
			"name": "Feeblemind",
			"url": "/api/spells/feeblemind"
		},
		{
			"index": "incendiary-cloud",
			"name": "Incendiary Cloud",
			"url": "/api/spells/incendiary-cloud"
		},
		{
			"index": "maze",
			"name": "Maze",
			"url": "/api/spells/maze"
		},
		{
			"index": "mind-blank",
			"name": "Mind Blank",
			"url": "/api/spells/mind-blank"
		},
		{
			"index": "power-word-stun",
			"name": "Power Word Stun",
			"url": "/api/spells/power-word-stun"
		},
		{
			"index": "sunburst",
			"name": "Sunburst",
			"url": "/api/spells/sunburst"
		},
		{
			"index": "astral-projection",
			"name": "Astral Projection",
			"url": "/api/spells/astral-projection"
		},
		{
			"index": "foresight",
			"name": "Foresight",
			"url": "/api/spells/foresight"
		},
		{
			"index": "gate",
			"name": "Gate",
			"url": "/api/spells/gate"
		},
		{
			"index": "imprisonment",
			"name": "Imprisonment",
			"url": "/api/spells/imprisonment"
		},
		{
			"index": "meteor-swarm",
			"name": "Meteor Swarm",
			"url": "/api/spells/meteor-swarm"
		},
		{
			"index": "power-word-kill",
			"name": "Power Word Kill",
			"url": "/api/spells/power-word-kill"
		},
		{
			"index": "prismatic-wall",
			"name": "Prismatic Wall",
			"url": "/api/spells/prismatic-wall"
		},
		{
			"index": "shapechange",
			"name": "Shapechange",
			"url": "/api/spells/shapechange"
		},
		{
			"index": "time-stop",
			"name": "Time Stop",
			"url": "/api/spells/time-stop"
		},
		{
			"index": "true-polymorph",
			"name": "True Polymorph",
			"url": "/api/spells/true-polymorph"
		},
		{
			"index": "weird",
			"name": "Weird",
			"url": "/api/spells/weird"
		},
		{
			"index": "wish",
			"name": "Wish",
			"url": "/api/spells/wish"
		}
	]
}
''';
