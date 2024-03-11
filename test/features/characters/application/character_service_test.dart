import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mythos_manager/features/authentication/data/authentication_repository.dart';
import 'package:mythos_manager/features/authentication/exceptions/no_user_found_exception.dart';
import 'package:mythos_manager/features/character_creator/domain/character.dart';
import 'package:mythos_manager/features/characters/application/character_service.dart';
import 'package:mythos_manager/features/characters/data/character_repository.dart';

import '../../../provider_container.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  group("CharacterService tests", () {
    late AuthenticationRepository mockAuthRepo;
    late MockUser mockUser;
    late CharacterRepository mockCharacterRepository;

    setUp(() {
      mockAuthRepo = MockAuthenticationRepository();
      mockUser = MockUser(uid: "valid-id");
      mockCharacterRepository = MockCharacterRepository();
    });

    test("fetchCharacters calls repo fetchCharactersForUser with user id",
        () async {
      final container = createContainer(overrides: [
        characterServiceProvider.overrideWith((ref) {
          return CharacterService(mockCharacterRepository, mockAuthRepo);
        })
      ]);

      when(() => mockAuthRepo.currentUser()).thenReturn(mockUser);
      when(() => mockCharacterRepository.fetchCharactersForUser("valid-id"))
          .thenAnswer((invocation) async => []);

      await container.read(characterServiceProvider).fetchCharacters();

      verify(() => mockCharacterRepository.fetchCharactersForUser("valid-id"))
          .called(1);
    });

    test("fetchCharacters throws NoUserFoundException when no user signed in",
        () async {
      final container = createContainer(overrides: [
        characterServiceProvider.overrideWith((ref) {
          return CharacterService(mockCharacterRepository, mockAuthRepo);
        })
      ]);

      when(() => mockAuthRepo.currentUser()).thenReturn(null);

      expectLater(container.read(characterServiceProvider).fetchCharacters(),
          throwsA(isA<NoUserFoundException>()));
    });
  });
}
