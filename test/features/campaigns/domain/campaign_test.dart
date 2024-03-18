import 'package:flutter_test/flutter_test.dart';
import 'package:mythos_manager/features/campaigns/domain/campaign.dart';

void main() {
  group("Campaign tests", () {
    Campaign campaign = Campaign(name: "name", description: "description");

    test("fromFirestore returns correct campaign model", () {
      expect(campaign.name, "name");
      expect(campaign.description, "description");
      expect(campaign.characterUID, null);
    });

    test("toFirestore returns correct map", () {
      expect(campaign.toFirestore(), {
        'name': 'name',
        'description': 'description'
      });
    });
  });
}
