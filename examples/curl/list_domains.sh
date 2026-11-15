#!/usr/bin/env bash
# List authorized domains using Ruby API with Bearer token authentication

set -euo pipefail

API_KEY_ID="${RUBY_KEY_ID:-YOUR_API_KEY_ID}"
API_KEY_SECRET="${RUBY_KEY_SECRET:-YOUR_API_KEY_SECRET}"
BASE_URL="${RUBY_BASE_URL:-https://api.rby.one}"

curl -X GET "${BASE_URL}/v1/domains" \
  -H "Authorization: Bearer ${API_KEY_ID}:${API_KEY_SECRET}"
echo ""
