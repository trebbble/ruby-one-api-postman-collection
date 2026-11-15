#!/usr/bin/env node
/**
 * Create a campaign link group using Ruby Developer REST API with Bearer token authentication.
 *
 * Node.js 18+ (native fetch supported)
 */

const API_KEY_ID = process.env.RUBY_KEY_ID || "YOUR_API_KEY_ID";
const API_KEY_SECRET = process.env.RUBY_KEY_SECRET || "YOUR_API_KEY_SECRET";
const BASE_URL = process.env.RUBY_BASE_URL || "https://api.rby.one";

async function createGroup() {
  const payload = {
    title: "Summer Campaign 2026",
    description: "Collection of promotional links for summer sales"
  };

  const response = await fetch(`${BASE_URL}/v1/groups`, {
    method: "POST",
    headers: {
      "Authorization": `Bearer ${API_KEY_ID}:${API_KEY_SECRET}`,
      "Content-Type": "application/json"
    },
    body: JSON.stringify(payload)
  });

  const data = await response.json();
  console.log("Status:", response.status);
  console.log("Response:", JSON.stringify(data, null, 2));
}

createGroup().catch(console.error);
