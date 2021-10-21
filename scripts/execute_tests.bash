#!/usr/bin/env bash

export TEST_REPORT_FOLDER_NAME="${REPORT_INDEX:-report}"

mkdir -p test_reports/"$TEST_REPORT_FOLDER_NAME"

export TEST_REPORT_FILE_NAME="tests.output"
export TEST_REPORT_JUNIT_FILE_NAME="tests-junit.xml"

export TEST_INTEGRATION_REPORT_FILE_NAME="tests-integration.output"
export TEST_INTEGRATION_REPORT_JUNIT_FILE_NAME="tests-integration-junit.xml"

# Execute tests
echo "Execute tests"
flutter_test="fvm flutter --suppress-analytics test --machine --coverage --coverage-path=coverage/lcov.tests.info --test-randomize-ordering-seed random > test_reports/$TEST_REPORT_FOLDER_NAME/$TEST_REPORT_FILE_NAME"
echo "$flutter_test"
eval "$flutter_test" || echo 'App tests failed'
flutter_test_report="fvm flutter --suppress-analytics pub global run junitreport:tojunit --input test_reports/$TEST_REPORT_FOLDER_NAME/$TEST_REPORT_FILE_NAME --output test_reports/$TEST_REPORT_FOLDER_NAME/$TEST_REPORT_JUNIT_FILE_NAME"
echo "$flutter_test_report"
eval "$flutter_test_report"

# Execute integration tests
echo "Execute integration tests"
flutter_integration_test="fvm flutter --suppress-analytics test integration_test --machine --coverage lib --coverage-path=coverage/lcov.tests-integration.info --dart-define=INTEGRATION_TEST=true > test_reports/$TEST_REPORT_FOLDER_NAME/$TEST_INTEGRATION_REPORT_FILE_NAME"
echo "$flutter_integration_test"
eval "$flutter_integration_test"
flutter_integration_test_report="fvm flutter --suppress-analytics pub global run junitreport:tojunit --input test_reports/$TEST_REPORT_FOLDER_NAME/$TEST_INTEGRATION_REPORT_FILE_NAME --output test_reports/$TEST_REPORT_FOLDER_NAME/$TEST_INTEGRATION_REPORT_JUNIT_FILE_NAME"
echo "$flutter_integration_test_report"
eval "$flutter_integration_test_report"
