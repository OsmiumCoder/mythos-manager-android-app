import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/characters/data/dnd_api_repository.dart';

/// Provides a [DNDAPIService].
final dndApiService = Provider<DNDAPIService>((ref) {
  return DNDAPIService(ref.watch(dndApiRepository));
});

/// Responsible for communication between controller and repository.
///
/// Authors: Jonathon Meney, Liam Welsh
class DNDAPIService {
  /// The [DNDAPIRepository] used to fetch API data.
  final DNDAPIRepository _repository;

  /// Constructs a [DNDAPIService].
  DNDAPIService(this._repository);

  /// Returns all playable races.
  Future<Map<String, dynamic>> getAllRaces() async {
    return await _repository.getAllRaces();
  }

  /// Returns specific information for a given race.
  Future<Map<String, dynamic>> getRace(String race) async {
    return await _repository.getRace(race);
  }

  /// Returns specific information for a given subrace.
  Future<Map<String, dynamic>> getSubrace(String subrace) async {
    return await _repository.getSubrace(subrace);
  }

  /// Returns all playable classes.
  Future<Map<String, dynamic>> getAllClasses() async {
    return await _repository.getAllClasses();
  }

  /// Returns specific information about a given class.
  Future<Map<String, dynamic>> getClass(String className) async {
    return await _repository.getClass(className);
  }

  /// Returns specific information about a given subclass.
  Future<Map<String, dynamic>> getSubclass(String subclass) async {
    return await _repository.getSubclass(subclass);
  }

  /// Returns all playable backgrounds.
  Future<Map<String, dynamic>> getAllBackgrounds() async {
    return await _repository.getAllBackgrounds();
  }

  /// Returns specific information about a given background.
  Future<Map<String, dynamic>> getBackground(String background) async {
    return await _repository.getBackground(background);
  }

  /// Returns all languages.
  Future<Map<String, dynamic>> getAllLanguages() async {
    return await _repository.getAllLanguages();
  }

  /// Returns the list of spells for a specific class.
  Future<Map<String, dynamic>> getSpellsForClass(String className) async {
    return await _repository.getSpellsForClass(className);
  }

  /// Returns list of equipment of a certain category
  Future<Map<String, dynamic>> getEquipment(String category) async {
    return await _repository.getEquipment(category);
  }


}
