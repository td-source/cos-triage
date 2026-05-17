#!/bin/bash
set -e
if [ -n "$GOOGLE_SERVICE_ACCOUNT_KEY" ]; then
  # Write to both locations to handle either resolution path
  echo "$GOOGLE_SERVICE_ACCOUNT_KEY" > /app/service-account-key.json
  echo "$GOOGLE_SERVICE_ACCOUNT_KEY" > /app/dist/service-account-key.json
fi
exec node dist/index.cjs
