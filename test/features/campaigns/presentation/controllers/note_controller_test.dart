import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mythos_manager/features/campaigns/application/campaign_service.dart';
import 'package:mythos_manager/features/campaigns/presentation/controllers/campaign_controller.dart';
import 'package:mythos_manager/features/campaigns/presentation/controllers/note_controller.dart';

import '../../../../provider_container.dart';

class MockCampaignService extends Mock implements CampaignService {}

void main() {
  group("NoteController tests", () {
    late CampaignService mockCampaignService;

    setUp(() {
      mockCampaignService = MockCampaignService();
    });

    test("build calls service fetchNotesForCampaign in service", () async {
      final container = createContainer(overrides: [
        campaignServiceProvider.overrideWith((ref) {
          return mockCampaignService;
        })
      ]);

      when(() => mockCampaignService.fetchNotesForCampaign("id"))
          .thenAnswer((invocation) async => []);

      expectLater(
          container.read(noteControllerProvider("id").future), completion([]));

      verify(() => mockCampaignService.fetchNotesForCampaign("id")).called(1);
    });

    test("createNote creates note and updates state", () {
      final container = createContainer(overrides: [
        campaignServiceProvider.overrideWith((ref) {
          return mockCampaignService;
        })
      ]);

      when(() => mockCampaignService.createNote("id", "title", "details"))
          .thenAnswer((invocation) async {});

      container
          .read(noteControllerProvider("id").notifier)
          .createNote("id", "title  ", "details");

      verify(() => mockCampaignService.fetchNotesForCampaign("id")).called(2);
    });
  });
}
