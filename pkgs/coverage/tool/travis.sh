#!/bin/bash

# Copyright (c) 2015, the Dart project authors. Please see the AUTHORS file
# for details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.

# Fast fail the script on failures.
set -e

# Verify that the libraries are error and warning-free.
echo "Running dartanalyzer..."
dartanalyzer $DARTANALYZER_FLAGS \
  bin/collect_coverage.dart \
  bin/format_coverage.dart \
  lib/coverage.dart

# Run the tests.
echo "Running tests..."
pub run test

# Install dart_coveralls; gather and send coverage data.
if [ "$COVERALLS_TOKEN" ] && [ "$TRAVIS_DART_VERSION" = "stable" ]; then
  echo "Running coverage..."

  # TODO: replace this work-around once pull-request lands
  # Pull request: https://github.com/duse-io/dart-coveralls/pull/32 lands
  pub global activate --source git https://github.com/kevmoo/dart_coveralls_hacking.git
  # pub global activate dart_coveralls
  pub global run dart_coveralls report \
    --token $COVERALLS_TOKEN \
    --retry 2 \
    --exclude-test-files \
    --debug \
    test/test_all.dart
fi
