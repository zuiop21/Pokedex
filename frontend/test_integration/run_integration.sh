#!/bin/bash

cd frontend && flutter drive --target=test_integration/auth_test.dart --driver=test_integration/integration_test_driver.dart
