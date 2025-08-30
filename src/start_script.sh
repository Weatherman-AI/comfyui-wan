#!/usr/bin/env bash
set -euo pipefail

# --- Config (allow override by env) ---
REPO_URL="${COMFY_REPO_URL:-https://github.com/Weatherman-AI/comfyui-wan.git}"
BRANCH="${COMFY_REPO_BRANCH:-main}"
TARGET_DIR="/workspace/comfyui-wan"
ENTRY_SRC_REL="src/start.sh"
ENTRY_DST="/start.sh"

echo "[init] Using repo: $REPO_URL (branch: $BRANCH)"

# --- Ensure git + SSL CA certs are available ---
if ! command -v git >/dev/null 2>&1; then
  echo "[init] Installing git..."
  apt-get update -y && apt-get install -y --no-install-recommends git ca-certificates && rm -rf /var/lib/apt/lists/*
fi

# --- Validate the repo URL before cloning ---
if ! git ls-remote --heads "$REPO_URL" >/dev/null 2>&1; then
  echo "[error] Unable to reach repo (or repo/branch is private): $REPO_URL"
  echo "        If private, set COMFY_REPO_URL to use a token: https://<TOKEN>@github.com/Weatherman-AI/comfyui-wan.git"
  exit 1
fi

# --- Clone shallow, specific branch ---
rm -rf "$TARGET_DIR"
git clone --depth 1 --branch "$BRANCH" "$REPO_URL" "$TARGET_DIR"

# --- Move entry script into place ---
SRC_PATH="$TARGET_DIR/$ENTRY_SRC_REL"
if [[ ! -f "$SRC_PATH" ]]; then
  echo "[error] Expected entry script not found at: $SRC_PATH"
  echo "        Check the path in your repo."
  exit 1
fi

cp "$SRC_PATH" "$ENTRY_DST"
chmod +x "$ENTRY_DST"

echo "[init] Launching $ENTRY_DST"
exec "$ENTRY_DST"
