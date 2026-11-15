#!/usr/bin/env bash
# Create a short link using Ruby API with Bearer token authentication

set -euo pipefail

API_KEY_ID="${RUBY_KEY_ID:-YOUR_API_KEY_ID}"
API_KEY_SECRET="${RUBY_KEY_SECRET:-YOUR_API_KEY_SECRET}"
BASE_URL="${RUBY_BASE_URL:-https://api.rby.one}"

curl -X POST "${BASE_URL}/v1/links" \
  -H "Authorization: Bearer ${API_KEY_ID}:${API_KEY_SECRET}" \
  -H "Content-Type: application/json" \
  -d '{
    "destination_url": "https://example.com/summer-promotion",
    "domain": "rby.one",
    "title": "Summer Campaign Link",
    "utm_source": "newsletter",
    "utm_medium": "email",
    "utm_campaign": "summer_sale",
    "forward_parameters": true
  }'
echo ""
