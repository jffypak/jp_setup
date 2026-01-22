#!/usr/bin/env bash
set -euo pipefail

# Run from the repo root (or adjust paths below if needed)

# 1) Load env vars used by arizeweb (includes GLOBAL_ID_HMAC_SECRET)
ENV_FILE="$HOME/Code/arize/arizeweb/.env"
if [[ ! -f "$ENV_FILE" ]]; then
  echo "Error: env file not found at: $ENV_FILE"
  exit 1
fi

# shellcheck disable=SC1090
source "$ENV_FILE"

# 2) Ensure GLOBAL_ID_HMAC_SECRET is exported (for relay global id encoding)
if [[ -z "${GLOBAL_ID_HMAC_SECRET:-}" ]]; then
  echo "Error: GLOBAL_ID_HMAC_SECRET is not set after sourcing $ENV_FILE"
  exit 1
fi
export GLOBAL_ID_HMAC_SECRET="$GLOBAL_ID_HMAC_SECRET"

# 3) Streaming secret (can be any arbitrary string)
export STREAM_LOCATOR_SECRET="${STREAM_LOCATOR_SECRET:-secret}"

# 4) Start Copilot server
cd $HOME/Code/arize/copilot
exec python server.py \
  --grpc-port=6011 \
  --http-port=6012 \
  --planner-persistence-mode=database \
  --log-to-arize \
  --reload

# might need to --log-to-phoenix
