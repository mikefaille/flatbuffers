#!/bin/bash
set -e
cd out
dart pub get
dart run main.dart