import 'dart:async';

import 'package:golden_toolkit/golden_toolkit.dart';

const INTEGRATION_TEST = bool.fromEnvironment('INTEGRATION_TEST');

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  if(INTEGRATION_TEST) return testMain();
  await loadAppFonts();
  return testMain();
}
