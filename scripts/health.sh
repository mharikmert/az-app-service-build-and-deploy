#!/usr/bin/env bash
set -euo pipefail

URL="${1:-}"
MAX_ATTEMPTS="${2:-20}"
SLEEP_SECONDS="${3:-15}"
LABEL="${4:-healthcheck}"

if [ -z "$URL" ]; then
  echo "❌ No URL provided to healthcheck script."
  exit 1
fi

echo "Starting healthcheck for $LABEL at $URL"
attempt=1

while [ "$attempt" -le "$MAX_ATTEMPTS" ]; do
  echo "Attempt $attempt/$MAX_ATTEMPTS..."
  if curl -fsS "$URL" > /dev/null; then
    echo "✅ $LABEL is healthy."
    exit 0
  fi

  echo "❌ $LABEL not healthy yet. Sleeping ${SLEEP_SECONDS}s..."
  sleep "$SLEEP_SECONDS"
  attempt=$((attempt+1))
done

echo "❌ $LABEL FAILED healthcheck after $MAX_ATTEMPTS attempts."
exit 1