import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tests/traveler/model/traveler.dart';
import 'package:flutter_tests/traveler/ui/screen/add_traveler_screen.dart';
import 'package:flutter_tests/traveler/ui/screen/add_traveler_success_screen.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_tests/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets(
        '''GIVEN a complete young traveler,
           WHEN add the traveler,
           THEN success''',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(((tester.widget(find.byKey(Key("TravelerTypeDropdown")).last) as DropdownButton)
          .value as TravelerType).toShortString(),
          equals('Adult'));

      await tester.tap(find.text('Adult').last);

      await tester.pumpAndSettle();

      await tester.tap(find.text('Young').last);

      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(Key("firstnameInput")), "Alexandre");
      await tester.enterText(find.byKey(Key("lastnameInput")), "Poichet");
      await tester.enterText(find.byKey(Key("ageInput")), "22");

      await tester.tap(find.text("Add"));

      await tester.pumpAndSettle();

      expect(find.byType(AddTravelerScreen), findsNothing);
      expect(find.byType(AddTravelerSuccessScreen), findsOneWidget);
      expect(find.text("Alexandre"), findsOneWidget);
      expect(find.text("Poichet"), findsOneWidget);
      expect(find.text("22"), findsOneWidget);
      expect(find.text(TravelerType.YOUNG.toShortString()), findsOneWidget);
    });
  });
}
