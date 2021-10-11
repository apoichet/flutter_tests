import 'package:flutter/material.dart';
import 'package:flutter_tests/traveler/model/traveler.dart';
import 'package:flutter_tests/traveler/ui/screen/add_traveler_success_screen.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../../golden_sizes_helper.dart';

void main() {
  testGoldens('Test Golden $AddTravelerSuccessScreen', (tester) async {
    final widget = MaterialApp(
      home: AddTravelerSuccessScreen(Traveler(firstName: "Jhon", lastName: "Doe", age: "36", type: TravelerType.ADULT)),
      debugShowCheckedModeBanner: false,
    );

    await tester.pumpWidgetBuilder(widget);

    await multiScreenGolden(tester, 'add_traveler_success',
        devices: GoldenSizeHelper.screens);
  });

  testGoldens('Test Golden $AddTravelerSuccessScreen with semantics', (tester) async {
    final widget = MaterialApp(
      home: AddTravelerSuccessScreen(Traveler(firstName: "Jhon", lastName: "Doe", age: "36", type: TravelerType.ADULT)),
      debugShowCheckedModeBanner: false,
      showSemanticsDebugger: true,
    );

    await tester.pumpWidgetBuilder(widget);

    await multiScreenGolden(tester, 'add_traveler_success',
        devices: [GoldenSizeHelper.semanticsScreen]);
  });
}
