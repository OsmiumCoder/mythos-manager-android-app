import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/application/dnd_api_service.dart';

/// Provides a [DNDAPIController].
final dndApiController = Provider<DNDAPIController>((ref) {
  return DNDAPIController(ref.watch(dndApiService));
});

/// Calls [DNDAPIService] to fetch data from public API.
///
/// Authors: Jonathon Meney, Liam Welsh
class DNDAPIController {
  /// The [DNDAPIService] used to fetch API data.
  final DNDAPIService _service;

  /// Constructs a [DNDAPIController].
  DNDAPIController(this._service);

  /// Returns all playable races.
  Future<Map<String, dynamic>> getAllRaces() async {
    return await _service.getAllRaces();
  }

  /// Returns specific information for a given race.
  Future<Map<String, dynamic>> getRace(String race) async {
    return await _service.getRace(race);
  }

  /// Returns specific information for a given subrace.
  Future<Map<String, dynamic>> getSubrace(String subrace) async {
    return await _service.getSubrace(subrace);
  }

  /// Returns all playable classes.
  Future<Map<String, dynamic>> getAllClasses() async {
    return await _service.getAllClasses();
  }

  /// Returns specific information about a given class.
  Future<Map<String, dynamic>> getClass(String className) async {
    return await _service.getClass(className);
  }

  /// Returns specific information about a given subclass.
  Future<Map<String, dynamic>> getSubclass(String subclass) async {
    return await _service.getSubclass(subclass);
  }

  /// Returns all playable backgrounds.
  Future<Map<String, dynamic>> getAllBackgrounds() async {
    return await _service.getAllBackgrounds();
  }

  /// Returns specific information about a given background.
  Future<Map<String, dynamic>> getBackground(String background) async {
    return await _service.getBackground(background);
  }

  /// Returns all languages.
  Future<Map<String, dynamic>> getAllLanguages() async {
    return await _service.getAllLanguages();
  }

  /// Returns the list of spells for a specific class.
  Future<List<Map<String, dynamic>>> getSpellsForClass(String className) async {
    return await _service.getSpellsForClass(className);
  }

  /// Returns list of equipment of a certain category
  Future<Map<String, dynamic>> getEquipment(String category) async {
    return await _service.getEquipment(category);
  }

  /// Returns list of class features.
  Future<List<Map<String, dynamic>>> getClassFeatures(String className) async {
    return await _service.getClassFeatures(className);
  }

  /// Returns list of subclass features.
  Future<List<Map<String, dynamic>>> getSubclassFeatures(
      String subclass) async {
    return await _service.getSubclassFeatures(subclass);
  }
}
