#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

if ! python -m build --version >/dev/null 2>&1; then
    echo "ERROR: Python package 'build' is not installed."
    echo
    echo "Install it with:"
    echo "    python -m pip install build"
    exit 1
fi

echo "==> Building native helper..."
"$ROOT/tools/build_helper.sh"

echo
echo "==> Building Python package..."

cd "$ROOT/bindings/python"

rm -rf build dist *.egg-info

python -m build

echo
echo "Done."
echo
echo "Artifacts:"
ls -lh dist