import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mythos_manager/features/campaigns/application/campaign_service.dart';
import 'package:mythos_manager/features/campaigns/presentation/controllers/campaign_controller.dart';

import '../../../../provider_container.dart';

class MockCampaignService extends Mock implements CampaignService {}

void main() {
  group("CampaignController tests", () {
    late CampaignService mockCampaignService;

    setUp(() {
      mockCampaignService = MockCampaignService();
    });

    test("build calls service fetchCampaigns in service", () async {
      final container = createContainer(overrides: [
        campaignServiceProvider.overrideWith((ref) {
          return mockCampaignService;
        })
      ]);

      when(() => mockCampaignService.fetchCampaigns())
          .thenAnswer((invocation) async => []);

      expectLater(
          container.read(campaignControllerProvider.future), completion([]));

      verify(() => mockCampaignService.fetchCampaigns()).called(1);
    });

    test("createCampaign creates campaign and updates state", () {
      final container = createContainer(overrides: [
        campaignServiceProvider.overrideWith((ref) {
          return mockCampaignService;
        })
      ]);

      when(() => mockCampaignService.createCampaign("name", "description", ""))
          .thenAnswer((invocation) async {});

      container
          .read(campaignControllerProvider.notifier)
          .createCampaign("name", "description", "");

      verify(() => mockCampaignService.fetchCampaigns()).called(2);
    });
  });
}
