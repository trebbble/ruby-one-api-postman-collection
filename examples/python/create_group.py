#!/usr/bin/env python3
"""
Create a campaign link group using Ruby Developer REST API with Bearer token authentication.

Prerequisites:
    pip install requests
"""
import os
import requests

API_KEY_ID = os.getenv("RUBY_KEY_ID", "YOUR_API_KEY_ID")
API_KEY_SECRET = os.getenv("RUBY_KEY_SECRET", "YOUR_API_KEY_SECRET")
BASE_URL = os.getenv("RUBY_BASE_URL", "https://api.rby.one")

payload = {
    "title": "Summer Campaign 2026",
    "description": "Collection of promotional links for summer sales",
}

headers = {
    "Authorization": f"Bearer {API_KEY_ID}:{API_KEY_SECRET}",
    "Content-Type": "application/json",
}

response = requests.post(f"{BASE_URL}/v1/groups", json=payload, headers=headers)
print("Status Code:", response.status_code)
print("Response Body:", response.json())
