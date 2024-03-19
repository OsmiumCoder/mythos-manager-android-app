import 'package:flutter_test/flutter_test.dart';
import 'package:mythos_manager/features/campaigns/domain/note.dart';

void main() {
  group("Note tests", () {
    Note note =
        Note(campaignUID: "id", title: "title", description: "description");

    test("fromFirestore returns correct note model", () {
      expect(note.campaignUID, "id");
      expect(note.title, "title");
      expect(note.description, "description");
    });

    test("toFirestore returns correct map", () {
      expect(note.toFirestore(), {
        'campaign_id': 'id',
        'title': 'title',
        'description': 'description'
      });
    });
  });
}
