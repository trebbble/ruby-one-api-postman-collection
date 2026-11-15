#!/usr/bin/env node
/**
 * Create a short link using Ruby Developer REST API with HMAC-SHA256 request signing.
 *
 * Node.js 18+ (native crypto and fetch supported)
 */

const { createHash, createHmac } = require("crypto");

const KEY_ID = process.env.RUBY_KEY_ID || "YOUR_API_KEY_ID";
const HMAC_SECRET = process.env.RUBY_HMAC_SECRET || "YOUR_HMAC_SECRET";
const BASE_URL = process.env.RUBY_BASE_URL || "https://api.rby.one";

async function createLinkHmac() {
  const payload = {
    destination_url: "https://example.com/summer-promotion",
    domain: "rby.one",
    title: "Summer Campaign HMAC Node",
    utm_source: "newsletter",
    utm_medium: "email",
    utm_campaign: "summer_sale",
    forward_parameters: true
  };

  const path = "/v1/links";
  const method = "POST";
  const timestamp = Math.floor(Date.now() / 1000).toString();
  const rawBody = JSON.stringify(payload);
  const bodyHash = createHash("sha256").update(rawBody).digest("hex");

  // Canonical string: {timestamp}\n{METHOD}\n{path}\n{body_hash}
  const stringToSign = `${timestamp}\n${method}\n${path}\n${bodyHash}`;
  const signature = createHmac("sha256", HMAC_SECRET).update(stringToSign).digest("hex");

  const response = await fetch(`${BASE_URL}${path}`, {
    method,
    headers: {
      "X-Rby-Key-Id": KEY_ID,
      "X-Rby-Timestamp": timestamp,
      "X-Rby-Signature": signature,
      "Content-Type": "application/json"
    },
    body: rawBody
  });

  const data = await response.json();
  console.log("Status:", response.status);
  console.log("Response:", JSON.stringify(data, null, 2));
}

createLinkHmac().catch(console.error);
