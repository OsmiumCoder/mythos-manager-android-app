import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mythos_manager/features/campaigns/application/campaign_service.dart';
import 'package:mythos_manager/features/campaigns/domain/note.dart';

/// Provides a [NoteController].
final noteControllerProvider = AsyncNotifierProvider.family<NoteController, List<Note>, String>(() {
  return NoteController();
});

/// Delegates requests related to [Note]'s.
///
/// Author: Jonathon Meney
class NoteController extends FamilyAsyncNotifier<List<Note>, String> {
  /// Creates a new [Note].
  Future<void> createNote(String campaignID, String title, String details) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      ref.watch(campaignServiceProvider).createNote(campaignID, title, details);
      return _fetchNotesForCampaign(campaignID);
    });
  }

  /// Returns a list of [Note]'s for a given campaign.
  Future<List<Note>> _fetchNotesForCampaign(String campaignID) async {
    return ref.watch(campaignServiceProvider).fetchNotesForCampaign(campaignID);
  }

  @override
  FutureOr<List<Note>> build(String arg) {
    return _fetchNotesForCampaign(arg);
  }
}