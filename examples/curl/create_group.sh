#!/usr/bin/env bash
# Create a campaign link group using Ruby API with Bearer token authentication

set -euo pipefail

API_KEY_ID="${RUBY_KEY_ID:-YOUR_API_KEY_ID}"
API_KEY_SECRET="${RUBY_KEY_SECRET:-YOUR_API_KEY_SECRET}"
BASE_URL="${RUBY_BASE_URL:-https://api.rby.one}"

curl -X POST "${BASE_URL}/v1/groups" \
  -H "Authorization: Bearer ${API_KEY_ID}:${API_KEY_SECRET}" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Summer Campaign 2026",
    "description": "Collection of promotional links for summer sales"
  }'
echo ""
