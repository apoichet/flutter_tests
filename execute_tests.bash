#!/usr/bin/env bash

# Execute tests
echo "Execute tests"
echo "fvm flutter --suppress-analytics test --coverage lib > test_report/tests.output"
fvm flutter --suppress-analytics test --machine --coverage --coverage-path=coverage/lcov.tests.info > test_report/tests.output || echo 'App tests failed'
echo "fvm flutter --suppress-analytics pub global run junitreport:tojunit --input test_report/tests.output --output test_report/tests-junit.xml"
fvm flutter --suppress-analytics pub global run junitreport:tojunit --input test_report/tests.output --output test_report/tests-junit.xml

# Execute integration tests
echo "Execute integration tests"
echo "fvm flutter --suppress-analytics test integration_tests --coverage lib --merge-coverage > test_report/tests-integration.output"
fvm flutter --suppress-analytics test integration_test --machine --coverage --coverage-path=coverage/lcov.tests-integration.info --dart-define=INTEGRATION_TEST=true > test_report/tests-integration.output || echo 'App tests failed'
echo "fvm flutter --suppress-analytics pub global run junitreport:tojunit --input test_report/tests-integration.output --output test_report/tests-integration-junit.xml"
fvm flutter --suppress-analytics pub global run junitreport:tojunit --input test_report/tests-integration.output --output test_report/tests-integration-junit.xml

# Generate coverage report
echo "Generate coverage report"
echo "lcov --add-tracefile coverage/lcov.tests.info -a coverage/lcov.tests-integration.info -o coverage/lcov.merged.info"
lcov --add-tracefile coverage/lcov.tests.info -a coverage/lcov.tests-integration.info -o coverage/lcov.merged.info
# Remove repository fake coverage
lcov --remove coverage/lcov.merged.info 'lib/repository/traveler_repository_fake.dart'
echo "genhtml coverage/lcov.merged.info -o coverage/html"
genhtml coverage/lcov.merged.info -o coverage/html
