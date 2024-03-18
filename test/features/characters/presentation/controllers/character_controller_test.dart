import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mythos_manager/features/characters/application/character_service.dart';
import 'package:mythos_manager/features/characters/presentation/controllers/character_controller.dart';

import '../../../../provider_container.dart';

class MockCharacterService extends Mock implements CharacterService {}

void main() {
  group("CharacterController tests", () {
    late MockCharacterService mockCharacterService;

    setUp(() {
      mockCharacterService = MockCharacterService();
    });

    test("build calls service fetchCharacters of service", () async {
      final container = createContainer(overrides: [
        characterServiceProvider.overrideWith((ref) {
          return mockCharacterService;
        })
      ]);

      when(() => mockCharacterService.fetchCharacters()).thenAnswer((invocation) async => []);

      expectLater(container.read(characterControllerProvider.future), completion([]));

      verify(() =>  mockCharacterService.fetchCharacters()).called(1);
    });
  });
}
