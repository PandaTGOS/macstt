#!/bin/bash

set -e

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

PROJECT="$ROOT/macstt-helper/macstt-helper.xcodeproj"

SCHEME="macstt-helper"

DESTINATION="$ROOT/python/macstt/helper"

echo "Building helper..."

xcodebuild \
    -project "$PROJECT" \
    -scheme "$SCHEME" \
    -configuration Release \
    BUILD_DIR="$ROOT/build" \
    build > /dev/null

HELPER="$ROOT/build/Release/macstt-helper"

if [ ! -f "$HELPER" ]; then
    echo "Build failed."
    exit 1
fi

mkdir -p "$DESTINATION"

cp "$HELPER" "$DESTINATION/macstt-helper"

chmod +x "$DESTINATION/macstt-helper"

echo "Helper copied to"

echo "$DESTINATION/macstt-helper"