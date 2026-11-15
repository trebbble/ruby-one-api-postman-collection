#!/usr/bin/env python3
"""
List authorized domains using Ruby Developer REST API with Bearer token authentication.

Prerequisites:
    pip install requests
"""
import os
import requests

API_KEY_ID = os.getenv("RUBY_KEY_ID", "YOUR_API_KEY_ID")
API_KEY_SECRET = os.getenv("RUBY_KEY_SECRET", "YOUR_API_KEY_SECRET")
BASE_URL = os.getenv("RUBY_BASE_URL", "https://api.rby.one")

headers = {
    "Authorization": f"Bearer {API_KEY_ID}:{API_KEY_SECRET}",
}

response = requests.get(f"{BASE_URL}/v1/domains", headers=headers)
print("Status Code:", response.status_code)
print("Response Body:", response.json())
