import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {

  late FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    driver.close();
  });

  test('performance test', () async {

    final timeline = await driver.traceAction(() async {
        await driver.tap(find.byValueKey('My ElevatedButton'));
        expect(await driver.getText(find.byValueKey('Add Text')), 'Add');
    });

    // write summary to a file
    final summary = new TimelineSummary.summarize(timeline);
    await summary.writeTimelineToFile('hello_test_perf', pretty: true, includeSummary: false);

  });

}
