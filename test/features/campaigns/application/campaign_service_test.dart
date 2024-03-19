import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mythos_manager/features/authentication/data/authentication_repository.dart';
import 'package:mythos_manager/features/authentication/exceptions/no_user_found_exception.dart';
import 'package:mythos_manager/features/campaigns/application/campaign_service.dart';
import 'package:mythos_manager/features/campaigns/data/campaign_repository.dart';
import 'package:mythos_manager/features/campaigns/domain/campaign.dart';

import '../../../provider_container.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockCampaignRepository extends Mock implements CampaignRepository {}

void main() {
  group("CampaignService tests", () {
    late AuthenticationRepository mockAuthRepo;
    late MockUser mockUser;
    late CampaignRepository mockCampaignRepository;

    setUp(() {
      mockAuthRepo = MockAuthenticationRepository();
      mockUser = MockUser(uid: "id");
      mockCampaignRepository = MockCampaignRepository();
      registerFallbackValue(
          Campaign(userID: "id", name: "name", description: "description"));
    });

    test("createCampaign calls repo createCampaign", () async {
      final container = createContainer(overrides: [
        campaignServiceProvider.overrideWith((ref) {
          return CampaignService(mockCampaignRepository, mockAuthRepo);
        })
      ]);

      when(() => mockAuthRepo.currentUser()).thenReturn(mockUser);
      when(() => mockCampaignRepository.createCampaign(any()))
          .thenAnswer((invocation) async => true);

      await container
          .read(campaignServiceProvider)
          .createCampaign("name", "description");

      verify(() => mockCampaignRepository.createCampaign(any())).called(1);
    });

    test("createCampaign throws NoUserFoundException when no user signed in",
        () async {
      final container = createContainer(overrides: [
        campaignServiceProvider.overrideWith((ref) {
          return CampaignService(mockCampaignRepository, mockAuthRepo);
        })
      ]);

      when(() => mockAuthRepo.currentUser()).thenReturn(null);

      expectLater(
          container
              .read(campaignServiceProvider)
              .createCampaign("name", "description"),
          throwsA(isA<NoUserFoundException>()));
    });

    test("fetchCampaigns calls repo fetchCampaigns with user id", () async {
      final container = createContainer(overrides: [
        campaignServiceProvider.overrideWith((ref) {
          return CampaignService(mockCampaignRepository, mockAuthRepo);
        })
      ]);

      when(() => mockAuthRepo.currentUser()).thenReturn(mockUser);
      when(() => mockCampaignRepository.fetchCampaignsForUser("id"))
          .thenAnswer((invocation) async => []);

      await container.read(campaignServiceProvider).fetchCampaigns();

      verify(() => mockCampaignRepository.fetchCampaignsForUser("id"))
          .called(1);
    });

    test("fetchCampaigns throws NoUserFoundException when no user signed in",
        () async {
      final container = createContainer(overrides: [
        campaignServiceProvider.overrideWith((ref) {
          return CampaignService(mockCampaignRepository, mockAuthRepo);
        })
      ]);

      when(() => mockAuthRepo.currentUser()).thenReturn(null);

      expectLater(container.read(campaignServiceProvider).fetchCampaigns(),
          throwsA(isA<NoUserFoundException>()));
    });
  });
}
