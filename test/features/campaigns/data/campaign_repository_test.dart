import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mythos_manager/features/campaigns/data/campaign_repository.dart';
import 'package:mythos_manager/features/campaigns/domain/campaign.dart';

import '../../../provider_container.dart';

void main() {
  group("CampaignRepository tests", () {
    Campaign campaign =
        Campaign(userID: "id", name: "name", description: "description");

    Campaign otherIdCampaign =
        Campaign(userID: "other-id", name: "name", description: "description");

    late FakeFirebaseFirestore fakeFirebaseFirestore;

    setUp(() {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
    });

    test("createCampaign stores campaign in firebase", () async {
      final container = createContainer(overrides: [
        campaignRepositoryProvider.overrideWith((ref) {
          return CampaignRepository(fakeFirebaseFirestore);
        })
      ]);

      container.read(campaignRepositoryProvider).createCampaign(campaign);
      final snapshot = await fakeFirebaseFirestore
          .collection('campaigns')
          .withConverter(
              fromFirestore: Campaign.fromFirestore,
              toFirestore: (Campaign character, options) =>
                  character.toFirestore())
          .get();

      // only one character should be stored
      expect(snapshot.docs.length, 1);

      Campaign storedCampaign = snapshot.docs.first.data();

      expect(storedCampaign.userID, "id");
      expect(storedCampaign.characterUID, null);
      expect(storedCampaign.name, "name");
      expect(storedCampaign.description, "description");
    });

    test("createCampaign stores campaign in firebase", () async {
      final container = createContainer(overrides: [
        campaignRepositoryProvider.overrideWith((ref) {
          return CampaignRepository(fakeFirebaseFirestore);
        })
      ]);

      container.read(campaignRepositoryProvider).createCampaign(campaign);
      container.read(campaignRepositoryProvider).createCampaign(campaign);

      final snapshot = await fakeFirebaseFirestore
          .collection('campaigns')
          .withConverter(
              fromFirestore: Campaign.fromFirestore,
              toFirestore: (Campaign character, options) =>
                  character.toFirestore())
          .get();

      // two characters should be stored
      // even though they are the same we can have 2 of the same
      expect(snapshot.docs.length, 2);
    });

    test("getCampaignsForUser returns list of campaigns for user", () async {
      final container = createContainer(overrides: [
        campaignRepositoryProvider.overrideWith((ref) {
          return CampaignRepository(fakeFirebaseFirestore);
        })
      ]);

      container.read(campaignRepositoryProvider).createCampaign(campaign);

      List<Campaign> campaigns = await container
          .read(campaignRepositoryProvider)
          .fetchCampaignsForUser("id");

      expect(campaigns, isA<List<Campaign>>());
      expect(campaigns.length, 1);
      expect(campaigns.first.userID, "id");
    });

    test("getCampaignsForUser returns only the characters of given user id",
        () async {
      final container = createContainer(overrides: [
        campaignRepositoryProvider.overrideWith((ref) {
          return CampaignRepository(fakeFirebaseFirestore);
        })
      ]);

      container.read(campaignRepositoryProvider).createCampaign(campaign);

      // add character that should not be returned
      container
          .read(campaignRepositoryProvider)
          .createCampaign(otherIdCampaign);

      List<Campaign> campaigns = await container
          .read(campaignRepositoryProvider)
          .fetchCampaignsForUser("id");

      expect(campaigns, isA<List<Campaign>>());
      expect(campaigns.length, 1);
    });
  });
}
