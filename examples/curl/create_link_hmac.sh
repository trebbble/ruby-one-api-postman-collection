#!/usr/bin/env bash
# Create a short link using Ruby API with HMAC-SHA256 request signing

set -euo pipefail

KEY_ID="${RUBY_KEY_ID:-YOUR_API_KEY_ID}"
HMAC_SECRET="${RUBY_HMAC_SECRET:-YOUR_HMAC_SECRET}"
BASE_URL="${RUBY_BASE_URL:-https://api.rby.one}"
METHOD="POST"
PATH_URL="/v1/links"

PAYLOAD='{"destination_url":"https://example.com/summer-promotion","domain":"rby.one","title":"Summer Campaign Link","utm_source":"newsletter","utm_medium":"email","utm_campaign":"summer_sale","forward_parameters":true}'

TIMESTAMP=$(date +%s)
BODY_HASH=$(printf "%s" "$PAYLOAD" | openssl dgst -sha256 | awk '{print $NF}')
STRING_TO_SIGN="${TIMESTAMP}
${METHOD}
${PATH_URL}
${BODY_HASH}"

SIGNATURE=$(printf "%s" "$STRING_TO_SIGN" | openssl dgst -sha256 -hmac "$HMAC_SECRET" | awk '{print $NF}')

curl -X POST "${BASE_URL}${PATH_URL}" \
  -H "X-Rby-Key-Id: ${KEY_ID}" \
  -H "X-Rby-Timestamp: ${TIMESTAMP}" \
  -H "X-Rby-Signature: ${SIGNATURE}" \
  -H "Content-Type: application/json" \
  -d "$PAYLOAD"
echo ""
