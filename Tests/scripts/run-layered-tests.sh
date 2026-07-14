#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
LAYER="${1:-preflight}"
BACKEND_ARTIFACTS_INSTALLED=0

lockfile_hash() {
  if command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$1" | awk '{print $1}'
  elif command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{print $1}'
  else
    echo "Neither shasum nor sha256sum is available." >&2
    exit 2
  fi
}

install_npm_deps() {
  local dir="$1"
  local sentinel_dir="$dir/node_modules/.cache/litemall-workshop"
  local sentinel="$sentinel_dir/package-lock.sha256"
  local expected_hash
  expected_hash="$(lockfile_hash "$dir/package-lock.json")"

  if [[ ! -d "$dir/node_modules" || ! -f "$sentinel" || "$(cat "$sentinel" 2>/dev/null || true)" != "$expected_hash" ]]; then
    echo "[setup] Installing npm dependencies in $dir..."
    (cd "$dir" && npm ci)
    mkdir -p "$sentinel_dir"
    printf '%s\n' "$expected_hash" > "$sentinel"
  fi
}

ensure_backend_artifacts() {
  if [[ "$BACKEND_ARTIFACTS_INSTALLED" == "0" ]]; then
    echo "[setup] Installing litemall backend modules into the local Maven repository..."
    (cd "$ROOT" && mvn -q -DskipTests install)
    BACKEND_ARTIFACTS_INSTALLED=1
  fi
}

preflight() {
  local failed=0
  for command in git java mvn node npm; do
    if command -v "$command" >/dev/null 2>&1; then
      printf '[ok] %-5s %s\n' "$command" "$(command -v "$command")"
    else
      printf '[missing] %s\n' "$command" >&2
      failed=1
    fi
  done

  for file in \
    "$ROOT/Tests/test-index.yml" \
    "$ROOT/Tests/contracts/product-browsing-api.contract.json" \
    "$ROOT/Tests/backend/src/test/java/org/linlinjava/litemall/tests/unit/WxProductBrowsingUnitTest.java" \
    "$ROOT/Tests/frontend/tests/it/mobile-product-browsing-api.it.test.ts" \
    "$ROOT/Tests/e2e/tests/product-browsing-flow.spec.ts"; do
    if [[ ! -f "$file" ]]; then
      echo "[missing] $file" >&2
      failed=1
    fi
  done

  [[ "$failed" == "0" ]] || exit 2
  echo "[ok] Product-discovery workshop files are present."
}

browse_backend_ut() {
  ensure_backend_artifacts
  (cd "$ROOT" && mvn -q -f Tests/backend/pom.xml -Dtest=WxProductBrowsingUnitTest test)
}

browse_contract() {
  ensure_backend_artifacts
  (cd "$ROOT" && mvn -q -f Tests/backend/pom.xml -Dtest=ProductBrowsingContractTest test)
}

browse_frontend_it() {
  install_npm_deps "$ROOT/Tests/frontend"
  (cd "$ROOT/Tests/frontend" && npm run test:browse-it)
}

browse_e2e() {
  install_npm_deps "$ROOT/Tests/e2e"
  (cd "$ROOT/Tests/e2e" && npx playwright install chromium && npm run test:browse)
}

browse_fast() {
  browse_backend_ut
  browse_contract
  browse_frontend_it
}

case "$LAYER" in
  preflight) preflight ;;
  browse-backend-ut) browse_backend_ut ;;
  browse-contract) browse_contract ;;
  browse-frontend-it) browse_frontend_it ;;
  browse-e2e) browse_e2e ;;
  browse-fast) browse_fast ;;
  *)
    echo "Usage: $0 [preflight|browse-backend-ut|browse-contract|browse-frontend-it|browse-e2e|browse-fast]" >&2
    exit 2
    ;;
esac
