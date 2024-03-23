
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mythos_manager/features/characters/application/dnd_api_service.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/dnd_api_controller.dart';

import '../../../../provider_container.dart';

class MockDNDAPIService extends Mock implements DNDAPIService {}

void main() {
  group("DNDAPIController tests", () {
    late DNDAPIService service;

    setUp(() {
      service = MockDNDAPIService();
    });

    test("getAllRaces calls getAllRaces in service", () {
      final container = createContainer(overrides: [
        dndApiController.overrideWith((ref) {
          return DNDAPIController(service);
        })
      ]);

      when(() => service.getAllRaces())
          .thenAnswer((_) async => {"success": 1});

      container.read(dndApiController).getAllRaces();

      verify(() => service.getAllRaces()).called(1);
    });

    test("getRace calls getRace in service", () {
      final container = createContainer(overrides: [
        dndApiController.overrideWith((ref) {
          return DNDAPIController(service);
        })
      ]);

      when(() => service.getRace(''))
          .thenAnswer((_) async => {"success": 1});

      container.read(dndApiController).getRace('');

      verify(() => service.getRace('')).called(1);
    });

    test("getSubrace calls getSubrace in service", () {
      final container = createContainer(overrides: [
        dndApiController.overrideWith((ref) {
          return DNDAPIController(service);
        })
      ]);

      when(() => service.getSubrace(''))
          .thenAnswer((_) async => {"success": 1});

      container.read(dndApiController).getSubrace('');

      verify(() => service.getSubrace('')).called(1);
    });

    test("getAllClasses calls getAllClasses in service", () {
      final container = createContainer(overrides: [
        dndApiController.overrideWith((ref) {
          return DNDAPIController(service);
        })
      ]);

      when(() => service.getAllClasses())
          .thenAnswer((_) async => {"success": 1});

      container.read(dndApiController).getAllClasses();

      verify(() => service.getAllClasses()).called(1);
    });

    test("getClass calls getClass in repository", () {
      final container = createContainer(overrides: [
        dndApiController.overrideWith((ref) {
          return DNDAPIController(service);
        })
      ]);

      when(() => service.getClass(''))
          .thenAnswer((_) async => {"success": 1});

      container.read(dndApiController).getClass('');

      verify(() => service.getClass('')).called(1);
    });

    test("getSubclass calls getSubclass in service", () {
      final container = createContainer(overrides: [
        dndApiController.overrideWith((ref) {
          return DNDAPIController(service);
        })
      ]);

      when(() => service.getSubclass(''))
          .thenAnswer((_) async => {"success": 1});

      container.read(dndApiController).getSubclass('');

      verify(() => service.getSubclass('')).called(1);
    });

    test("getAllBackgrounds calls getAllBackgrounds in service", () {
      final container = createContainer(overrides: [
        dndApiController.overrideWith((ref) {
          return DNDAPIController(service);
        })
      ]);

      when(() => service.getAllBackgrounds())
          .thenAnswer((_) async => {"success": 1});

      container.read(dndApiController).getAllBackgrounds();

      verify(() => service.getAllBackgrounds()).called(1);
    });

    test("getBackground calls getBackground in service", () {
      final container = createContainer(overrides: [
        dndApiController.overrideWith((ref) {
          return DNDAPIController(service);
        })
      ]);

      when(() => service.getBackground(''))
          .thenAnswer((_) async => {"success": 1});

      container.read(dndApiController).getBackground('');

      verify(() => service.getBackground('')).called(1);
    });

    test("getAllLanguages calls getAllLanguages in repository", () {
      final container = createContainer(overrides: [
        dndApiController.overrideWith((ref) {
          return DNDAPIController(service);
        })
      ]);

      when(() => service.getAllLanguages())
          .thenAnswer((_) async => {"success": 1});

      container.read(dndApiController).getAllLanguages();

      verify(() => service.getAllLanguages()).called(1);
    });

    test("getSpellsForClass calls getSpellsForClass in repository", () {
      final container = createContainer(overrides: [
        dndApiController.overrideWith((ref) {
          return DNDAPIController(service);
        })
      ]);

      when(() => service.getSpellsForClass(''))
          .thenAnswer((_) async => {"success": 1});

      container.read(dndApiController).getSpellsForClass('');

      verify(() => service.getSpellsForClass('')).called(1);
    });

    test("getClassFeatures calls getClassFeatures in service", () {
      final container = createContainer(overrides: [
        dndApiController.overrideWith((ref) {
          return DNDAPIController(service);
        })
      ]);

      when(() => service.getClassFeatures(''))
          .thenAnswer((_) async => []);

      container.read(dndApiController).getClassFeatures('');

      verify(() => service.getClassFeatures('')).called(1);
    });

    test("getSubclassFeatures calls getSubclassFeatures in service", () {
      final container = createContainer(overrides: [
        dndApiController.overrideWith((ref) {
          return DNDAPIController(service);
        })
      ]);

      when(() => service.getSubclassFeatures(''))
          .thenAnswer((_) async => []);

      container.read(dndApiController).getSubclassFeatures('');

      verify(() => service.getSubclassFeatures('')).called(1);
    });
  });
}