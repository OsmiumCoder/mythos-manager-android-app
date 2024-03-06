import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

/// Provides a [DNDAPIRepository].
final dndApiRepository = Provider<DNDAPIRepository>((ref) {
  return DNDAPIRepository();
});

/// Responsible for fetching all API data for character creation.
///
/// Author: Jonathon Meney
class DNDAPIRepository {
  /// Base api endpoint for the DND API.
  final apiEndpoint = "https://www.dnd5eapi.co/api";

  /// The [http.Client] for making api requests.
  final http.Client client;

  /// Constructs a [DNDAPIRepository].
  DNDAPIRepository({client}) : client = client ?? http.Client();

  /// Returns all playable races.
  Future<Map<String, dynamic>> getAllRaces() async {
    const String raceEndpoint = '/races';
    final response = await client.get(Uri.parse(apiEndpoint + raceEndpoint));
    return jsonDecode(response.body);
  }

  /// Returns specific information for a given race.
  Future<Map<String, dynamic>> getRace(String race) async {
    const String raceEndpoint = '/races/';
    final response =
        await client.get(Uri.parse(apiEndpoint + raceEndpoint + race));
    return jsonDecode(response.body);
  }

  /// Returns specific information for a given subrace.
  Future<Map<String, dynamic>> getSubrace(String subrace) async {
    const String subraceEndpoint = '/subraces/';
    final response =
        await client.get(Uri.parse(apiEndpoint + subraceEndpoint + subrace));
    return jsonDecode(response.body);
  }

  /// Returns all playable classes.
  Future<Map<String, dynamic>> getAllClasses() async {
    const String classEndpoint = '/classes';
    final response = await client.get(Uri.parse(apiEndpoint + classEndpoint));
    return jsonDecode(response.body);
  }

  /// Returns specific information about a given class.
  Future<Map<String, dynamic>> getClass(String className) async {
    const String classEndpoint = '/classes/';
    final response =
        await client.get(Uri.parse(apiEndpoint + classEndpoint + className));
    return jsonDecode(response.body);
  }

  /// Returns specific information about a given subclass.
  Future<Map<String, dynamic>> getSubclass(String subclass) async {
    const String subclassEndpoint = '/subclasses/';
    final response =
        await client.get(Uri.parse(apiEndpoint + subclassEndpoint + subclass));
    return jsonDecode(response.body);
  }

  /// Returns all playable backgrounds.
  Future<Map<String, dynamic>> getAllBackgrounds() async {
    const String backgroundEndpoint = '/backgrounds';
    final response =
        await client.get(Uri.parse(apiEndpoint + backgroundEndpoint));
    return jsonDecode(response.body);
  }

  /// Returns specific information about a given background.
  Future<Map<String, dynamic>> getBackground(String background) async {
    const String backgroundEndpoint = '/backgrounds/';
    final response = await client
        .get(Uri.parse(apiEndpoint + backgroundEndpoint + background));
    return jsonDecode(response.body);
  }

  /// Returns all languages.
  Future<Map<String, dynamic>> getAllLanguages() async {
    const String languagesEndpoint = '/languages';
    final response =
        await client.get(Uri.parse(apiEndpoint + languagesEndpoint));
    return jsonDecode(response.body);
  }

  /// Returns the list of spells for a specific class.
  Future<Map<String, dynamic>> getSpellsForClass(String className) async {
    const String classEndpoint = '/classes/';
    const String spellsEndpoint = '/spells';
    final response = await client.get(
        Uri.parse(apiEndpoint + classEndpoint + className + spellsEndpoint));
    return jsonDecode(response.body);
  }
}
