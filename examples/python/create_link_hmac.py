#!/usr/bin/env python3
"""
Create a short link using Ruby Developer REST API with HMAC-SHA256 request signing.

Prerequisites:
    pip install requests
"""
import hashlib
import hmac
import json
import os
import time
import requests

KEY_ID = os.getenv("RUBY_KEY_ID", "YOUR_API_KEY_ID")
HMAC_SECRET = os.getenv("RUBY_HMAC_SECRET", "YOUR_HMAC_SECRET")
BASE_URL = os.getenv("RUBY_BASE_URL", "https://api.rby.one")

payload = {
    "destination_url": "https://example.com/summer-promotion",
    "domain": "rby.one",
    "title": "Summer Campaign HMAC",
    "utm_source": "newsletter",
    "utm_medium": "email",
    "utm_campaign": "summer_sale",
    "forward_parameters": True,
}

# Compact JSON serialization matching canonical body bytes
body_bytes = json.dumps(payload, separators=(',', ':')).encode("utf-8")
body_hash = hashlib.sha256(body_bytes).hexdigest()
timestamp = str(int(time.time()))
method = "POST"
path = "/v1/links"

sig_string = f"{timestamp}\n{method}\n{path}\n{body_hash}"
signature = hmac.new(
    key=HMAC_SECRET.encode("utf-8"),
    msg=sig_string.encode("utf-8"),
    digestmod=hashlib.sha256
).hexdigest()

headers = {
    "X-Rby-Key-Id": KEY_ID,
    "X-Rby-Timestamp": timestamp,
    "X-Rby-Signature": signature,
    "Content-Type": "application/json",
}

response = requests.post(f"{BASE_URL}{path}", data=body_bytes, headers=headers)
print("Status Code:", response.status_code)
print("Response Body:", response.json())
