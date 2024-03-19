import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mythos_manager/features/campaigns/data/campaign_repository.dart';
import 'package:mythos_manager/features/campaigns/domain/campaign.dart';
import 'package:mythos_manager/features/campaigns/domain/note.dart';

import '../../../provider_container.dart';

void main() {
  group("CampaignRepository tests", () {
    Campaign campaign =
        Campaign(userID: "id", name: "name", description: "description");

    Campaign otherIdCampaign =
        Campaign(userID: "other-id", name: "name", description: "description");

    Note note =
        Note(campaignUID: "id", title: "title", description: "description");

    Note otherIdNote = Note(
        campaignUID: "other-id", title: "title", description: "description");

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

      // only one campaign should be stored
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

      // two campaigns should be stored
      // even though they are the same we can have 2 of the same
      expect(snapshot.docs.length, 2);
    });

    test("fetchCampaignsForUser returns list of campaigns for user", () async {
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

    test("fetchCampaignsForUser returns only the characters of given user id",
        () async {
      final container = createContainer(overrides: [
        campaignRepositoryProvider.overrideWith((ref) {
          return CampaignRepository(fakeFirebaseFirestore);
        })
      ]);

      container.read(campaignRepositoryProvider).createCampaign(campaign);

      // add campaign that should not be returned
      container
          .read(campaignRepositoryProvider)
          .createCampaign(otherIdCampaign);

      List<Campaign> campaigns = await container
          .read(campaignRepositoryProvider)
          .fetchCampaignsForUser("id");

      expect(campaigns, isA<List<Campaign>>());
      expect(campaigns.length, 1);
    });

    test("createNote stores note in firebase", () async {
      final container = createContainer(overrides: [
        campaignRepositoryProvider.overrideWith((ref) {
          return CampaignRepository(fakeFirebaseFirestore);
        })
      ]);

      container.read(campaignRepositoryProvider).createNote(note);
      final snapshot = await fakeFirebaseFirestore
          .collection('notes')
          .withConverter(
              fromFirestore: Note.fromFirestore,
              toFirestore: (Note character, options) => character.toFirestore())
          .get();

      // only one note should be stored
      expect(snapshot.docs.length, 1);

      Note storedNote = snapshot.docs.first.data();

      expect(storedNote.campaignUID, "id");
      expect(storedNote.title, "title");
      expect(storedNote.description, "description");
    });

    test("fetchNotesForCampaign returns list of notes for campaign", () async {
      final container = createContainer(overrides: [
        campaignRepositoryProvider.overrideWith((ref) {
          return CampaignRepository(fakeFirebaseFirestore);
        })
      ]);

      container.read(campaignRepositoryProvider).createNote(note);

      List<Note> notes = await container
          .read(campaignRepositoryProvider)
          .fetchNotesForCampaign("id");

      expect(notes, isA<List<Note>>());
      expect(notes.length, 1);
      expect(notes.first.campaignUID, "id");
    });

    test("fetchNotesForCampaign returns only the notes of given campaign id",
        () async {
      final container = createContainer(overrides: [
        campaignRepositoryProvider.overrideWith((ref) {
          return CampaignRepository(fakeFirebaseFirestore);
        })
      ]);

      container.read(campaignRepositoryProvider).createNote(note);

      // add note that should not be returned
      container.read(campaignRepositoryProvider).createNote(otherIdNote);

      List<Note> notes = await container
          .read(campaignRepositoryProvider)
          .fetchNotesForCampaign("id");

      expect(notes, isA<List<Note>>());
      expect(notes.length, 1);
    });
  });
}
