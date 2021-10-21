#!/usr/bin/env bash

# Generate coverage report
echo "Generate coverage report"
lcov_merge_coverage="lcov --add-tracefile coverage/lcov.tests.info -a coverage/lcov.tests-integration.info -o coverage/lcov.merged.info"
echo "$lcov_merge_coverage"
eval "$lcov_merge_coverage"

# Remove repository fake coverage
lcov --remove coverage/lcov.merged.info 'lib/traveler/repository/traveler_repository_fake.dart' -o coverage/lcov.info

gen_report_html="genhtml coverage/lcov.info -o coverage/html"
echo "$gen_report_html"
eval "$gen_report_html"

rm coverage/lcov.tests.info
rm coverage/lcov.tests-integration.info
rm coverage/lcov.merged.info
