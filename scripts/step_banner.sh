#!/usr/bin/env bash
set -euo pipefail

LABEL="${1:-}"

# STEP_COUNTER and TOTAL_STEPS come from the environment
COUNTER="${STEP_COUNTER:-0}"
TOTAL="${TOTAL_STEPS:-0}"

COUNTER=$((COUNTER + 1))

# persist updated counter for next steps
echo "STEP_COUNTER=$COUNTER" >> "$GITHUB_ENV"

if [ -z "$LABEL" ]; then
  LABEL="Step"
fi

echo "---------------------------------------------------------- [${COUNTER}/${TOTAL}] ${LABEL} ---------------------------------------------------------- "