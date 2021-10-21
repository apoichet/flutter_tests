import 'package:flutter/material.dart';
import 'package:flutter_tests/traveler/model/traveler.dart';
import 'package:flutter_tests/traveler/ui/screen/add_traveler_success_screen.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../../golden_helper.dart';

void main() {
  testGoldens('Test Golden $AddTravelerSuccessScreen', (tester) async {
    final widget = MaterialApp(
      home: AddTravelerSuccessScreen(Traveler(firstName: "Jhon", lastName: "Doe", age: "36", type: TravelerType.ADULT)),
      debugShowCheckedModeBanner: false,
    );

    await tester.pumpWidgetBuilder(widget);

    await multiScreenGolden(tester, 'add_traveler_success',
        devices: GoldenSizeHelper.screens);

    await tester.pumpWidgetBuilder(GoldenSemantics(child: widget));

    await multiScreenGolden(tester, 'add_traveler_success',
        devices: [GoldenSizeHelper.semanticsScreen]);
  });
}
