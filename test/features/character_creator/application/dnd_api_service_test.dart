import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mythos_manager/features/character_creator/application/dnd_api_service.dart';
import 'package:mythos_manager/features/character_creator/data/dnd_api_repository.dart';

import '../../../provider_container.dart';

class MockDNDAPIRepository extends Mock implements DNDAPIRepository {}

void main() {
  group("DNDAPIService tests", () {
    late DNDAPIRepository repository;

    setUp(() {
      repository = MockDNDAPIRepository();
    });

    test("getAllRaces calls getAllRaces in repository", () {
      final container = createContainer(overrides: [
        dndApiService.overrideWith((ref) {
          return DNDAPIService(repository);
        })
      ]);

      when(() => repository.getAllRaces())
          .thenAnswer((_) async => {"success": 1});

      container.read(dndApiService).getAllRaces();

      verify(() => repository.getAllRaces()).called(1);
    });

    test("getRace calls getRace in repository", () {
      final container = createContainer(overrides: [
        dndApiService.overrideWith((ref) {
          return DNDAPIService(repository);
        })
      ]);

      when(() => repository.getRace(''))
          .thenAnswer((_) async => {"success": 1});

      container.read(dndApiService).getRace('');

      verify(() => repository.getRace('')).called(1);
    });

    test("getSubrace calls getSubrace in repository", () {
      final container = createContainer(overrides: [
        dndApiService.overrideWith((ref) {
          return DNDAPIService(repository);
        })
      ]);

      when(() => repository.getSubrace(''))
          .thenAnswer((_) async => {"success": 1});

      container.read(dndApiService).getSubrace('');

      verify(() => repository.getSubrace('')).called(1);
    });

    test("getAllClasses calls getAllClasses in repository", () {
      final container = createContainer(overrides: [
        dndApiService.overrideWith((ref) {
          return DNDAPIService(repository);
        })
      ]);

      when(() => repository.getAllClasses())
          .thenAnswer((_) async => {"success": 1});

      container.read(dndApiService).getAllClasses();

      verify(() => repository.getAllClasses()).called(1);
    });

    test("getClass calls getClass in repository", () {
      final container = createContainer(overrides: [
        dndApiService.overrideWith((ref) {
          return DNDAPIService(repository);
        })
      ]);

      when(() => repository.getClass(''))
          .thenAnswer((_) async => {"success": 1});

      container.read(dndApiService).getClass('');

      verify(() => repository.getClass('')).called(1);
    });

    test("getSubclass calls getSubclass in repository", () {
      final container = createContainer(overrides: [
        dndApiService.overrideWith((ref) {
          return DNDAPIService(repository);
        })
      ]);

      when(() => repository.getSubclass(''))
          .thenAnswer((_) async => {"success": 1});

      container.read(dndApiService).getSubclass('');

      verify(() => repository.getSubclass('')).called(1);
    });

    test("getAllBackgrounds calls getAllBackgrounds in repository", () {
      final container = createContainer(overrides: [
        dndApiService.overrideWith((ref) {
          return DNDAPIService(repository);
        })
      ]);

      when(() => repository.getAllBackgrounds())
          .thenAnswer((_) async => {"success": 1});

      container.read(dndApiService).getAllBackgrounds();

      verify(() => repository.getAllBackgrounds()).called(1);
    });

    test("getBackground calls getBackground in repository", () {
      final container = createContainer(overrides: [
        dndApiService.overrideWith((ref) {
          return DNDAPIService(repository);
        })
      ]);

      when(() => repository.getBackground(''))
          .thenAnswer((_) async => {"success": 1});

      container.read(dndApiService).getBackground('');

      verify(() => repository.getBackground('')).called(1);
    });

    test("getAllLanguages calls getAllLanguages in repository", () {
      final container = createContainer(overrides: [
        dndApiService.overrideWith((ref) {
          return DNDAPIService(repository);
        })
      ]);

      when(() => repository.getAllLanguages())
          .thenAnswer((_) async => {"success": 1});

      container.read(dndApiService).getAllLanguages();

      verify(() => repository.getAllLanguages()).called(1);
    });

    test("getSpellsForClass calls getSpellsForClass in repository", () {
      final container = createContainer(overrides: [
        dndApiService.overrideWith((ref) {
          return DNDAPIService(repository);
        })
      ]);

      when(() => repository.getSpellsForClass(''))
          .thenAnswer((_) async => {"success": 1});

      container.read(dndApiService).getSpellsForClass('');

      verify(() => repository.getSpellsForClass('')).called(1);
    });
  });
}
