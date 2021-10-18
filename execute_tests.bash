#!/usr/bin/env bash

# Execute tests
echo "Execute tests"
flutter_test="fvm flutter --suppress-analytics test --machine --coverage --coverage-path=coverage/lcov.tests.info --test-randomize-ordering-seed=random > test_report/tests.output"
echo "$flutter_test"
eval "$flutter_test" || echo 'App tests failed'
flutter_test_report="fvm flutter --suppress-analytics pub global run junitreport:tojunit --input test_report/tests.output --output test_report/tests-junit.xml"
echo "$flutter_test_report"
eval "$flutter_test_report"

# Execute integration tests
echo "Execute integration tests"
flutter_integration_test="fvm flutter --suppress-analytics test integration_tests --machine --coverage --coverage-path=coverage/lcov.tests-integration.info --dart-define=INTEGRATION_TEST=true > test_report/tests-integration.output"
echo "$flutter_integration_test"
eval "$flutter_integration_test"
flutter_integration_test_report="fvm flutter --suppress-analytics pub global run junitreport:tojunit --input test_report/tests-integration.output --output test_report/tests-integration-junit.xml"
echo "$flutter_integration_test_report"
eval "$flutter_integration_test_report"

# Generate coverage report
echo "Generate coverage report"
lcov_merge_coverage="lcov --add-tracefile coverage/lcov.tests.info -a coverage/lcov.tests-integration.info -o coverage/lcov.merged.info"
echo "$lcov_merge_coverage"
eval "$lcov_merge_coverage"
# Remove repository fake coverage
lcov --remove coverage/lcov.merged.info 'lib/repository/traveler_repository_fake.dart'
gen_report_html="genhtml coverage/lcov.merged.info -o coverage/html"
echo "$gen_report_html"
eval "$gen_report_html"
