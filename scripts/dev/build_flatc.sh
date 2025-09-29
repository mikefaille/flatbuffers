#!/usr/bin/env bash
set -euo pipefail

# 1) Ensure we’re at repo root
if [ ! -f CMakeLists.txt ]; then
  echo "ERROR: Run from the repository root (where CMakeLists.txt is)."
  exit 1
fi

# 2) Make git happy for Version.cmake
git config --global --add safe.directory "$(pwd)" || true

# If shallow, unshallow; in all cases ensure tags exist for git describe
if git rev-parse --is-shallow-repository >/dev/null 2>&1 && \
   [ "$(git rev-parse --is-shallow-repository)" = "true" ]; then
  git fetch --unshallow --tags
else
  git fetch --tags || true
fi

# 3) Stable out-of-source build dir
BUILD_DIR="${BUILD_DIR:-build}"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

# 4) Configure
cmake -S . -B "$BUILD_DIR" \
  -DFLATBUFFERS_BUILD_TESTS=OFF \
  -DFLATBUFFERS_BUILD_BENCHMARKS=OFF \
  -DFLATBUFFERS_BUILD_FLATHASH=OFF \
  -DFLATBUFFERS_BUILD_FLATLIB=OFF \
  -DCMAKE_BUILD_TYPE=Release

# 5) Build just flatc
cmake --build "$BUILD_DIR" --target flatc -j"$(command -v nproc >/dev/null && nproc || echo 4)"

echo "OK: $BUILD_DIR/flatc"
"$BUILD_DIR/flatc" --help >/dev/null || true