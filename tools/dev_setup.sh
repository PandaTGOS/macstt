#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

echo "==> Installing development tools..."
python -m pip install --upgrade pip
python -m pip install -U build

echo
echo "==> Building native helper..."
"$ROOT/tools/build_helper.sh"

echo
echo "==> Installing editable package..."
python -m pip install -e "$ROOT/bindings/python"

echo
echo "Development environment ready."