import 'package:flutter_driver/flutter_driver.dart' as driver;
import 'package:integration_test/integration_test_driver.dart';

Future<void> main() {
  return integrationDriver(
    responseDataCallback: (data) async {
      if (data != null) {
        final timeline = driver.Timeline.fromJson(data['end_to_end_test']);

        final summary = driver.TimelineSummary.summarize(timeline);

        await summary.writeTimelineToFile(
          'end_to_end_test_output',
          pretty: true,
          includeSummary: true,
        );
      }
    },
  );
}
