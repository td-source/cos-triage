#!/bin/bash
if [ -n "$GOOGLE_SERVICE_ACCOUNT_KEY" ]; then
  echo "$GOOGLE_SERVICE_ACCOUNT_KEY" > dist/service-account-key.json
fi
node dist/index.cjs
