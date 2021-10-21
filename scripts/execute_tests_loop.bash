#!/usr/bin/env bash

nbrSeries=10

for x in $(seq 1 $nbrSeries); do
  export REPORT_INDEX=$x
  ./scripts/execute_tests.bash
  done
