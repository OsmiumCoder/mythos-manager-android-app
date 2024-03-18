import 'package:flutter_test/flutter_test.dart';
import 'package:mythos_manager/features/campaigns/domain/campaign.dart';

void main() {
  group("Campaign tests", () {
    Campaign campaign = Campaign(userID: "id", name: "name", description: "description");

    test("fromFirestore returns correct campaign model", () {
      expect(campaign.userID, "id");
      expect(campaign.name, "name");
      expect(campaign.description, "description");
      expect(campaign.characterUID, null);
    });

    test("toFirestore returns correct map", () {
      expect(campaign.toFirestore(), {
        "user_id": "id",
        'name': 'name',
        'description': 'description'
      });
    });
  });
}
