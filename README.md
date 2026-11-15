# Ruby Developer REST API — Official Postman Collection & Quickstart

[![OpenAPI 3.1](https://img.shields.io/badge/OpenAPI-3.1-6BA539?style=flat&logo=openapi-initiative&logoColor=white)](./openapi_v1.json)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)
[![Run in Postman](https://img.shields.io/badge/Postman-Run%20in%20Postman-FF6C37?style=flat&logo=postman&logoColor=white)](https://www.postman.com/ruby-one/ruby-public-api)

The official Postman collection, OpenAPI 3.1 specification, and quickstart guides for the **[Ruby](https://rby.one)** Developer REST API.

**Ruby** is a modern, high-performance enterprise URL shortener and link management platform offering ultra-low latency global redirects, dynamic vector QR codes, deep real-time clickstream analytics, and transparent tier capacity with zero link rot.

---

## Key Features

- **Short Link Management**: Create short links on the default `rby.one` domain (auto-allocated 8-character Base36 codes) or verified branded custom domains (with custom aliases).
- **Dynamic QR Codes & Device Targeting**: Mobile operating system routing (iOS App Store vs. Android Google Play URLs) and instant scannable QR codes for print collateral.
- **Link Groups & Batch Operations**: Organize links into campaign collections, retrieve aggregated metrics, programmatically batch create links, and export full CSV datasets.
- **Dual Authentication**:
  - **Basic Bearer Token** (`Authorization: Bearer <key_id>:<key_secret>`) for frictionless server-to-server integration.
  - **Enterprise HMAC-SHA256 Request Signing** (`X-Rby-Key-Id`, `X-Rby-Timestamp`, `X-Rby-Signature`) for tamper-proof requests and replay defense.
- **Real-Time Clickstream Analytics**: Time-series click metrics, unique visitors, bot filtering, and categorical breakdowns (devices, browsers, OS, countries, referrers).
- **Predictable Rate Limiting**: Sliding-window token bucket with standardized rate limit headers (`X-RateLimit-Limit`, `X-RateLimit-Remaining`, `X-RateLimit-Reset`, `Retry-After`).

---

## Quickstart with Postman

You can get started either by opening the official Postman public workspace or by importing the collection files manually.

### Option A: Open in Postman Public Workspace (Recommended)
1. Navigate to the **[Ruby Public API Workspace](https://www.postman.com/ruby-one/ruby-public-api)** on Postman.
2. Select the **Ruby Developer API** collection and click **Fork** to add it to your own Postman workspace.
3. Select the **Ruby API (Production)** environment.

### Option B: Manual File Import
1. Clone this repository or download the files from [`postman/`](./postman/):
   - [`postman/RubyOne_API.postman_collection.json`](./postman/RubyOne_API.postman_collection.json)
   - [`postman/RubyOne_Environment.postman_environment.json`](./postman/RubyOne_Environment.postman_environment.json)
2. Open Postman and click **Import** to load both files.
3. Select the **Ruby API (Production)** environment.

### Configure Your Credentials
In your Postman Environment, fill in your credentials obtained from the Ruby CMS dashboard (**Settings > Developer**):
- `baseUrl`: `https://api.rby.one`
- `authMethod`: `bearer` (default) or `hmac`
- `apiKeyId`: Your API Key ID (`ak_...`)
- `apiKeySecret`: Your API Key Secret (for `bearer` mode, `as_...`)
- `hmacSecret`: Your HMAC Secret (only needed if `authMethod` is set to `hmac`, `hs_...`)
- `defaultDomain`: Default short domain (e.g. `rby.one` or your verified custom domain)
- `shortCode`: Sample short code for lookup requests
- `linkPublicId`: Sample link public ID (e.g. `lnk_...`)
- `groupPublicId`: Sample group public ID (e.g. `grp_...`)

> **Note**: The collection includes an automatic **Pre-request Script** that signs requests using HMAC-SHA256 when `authMethod` is set to `hmac`, or formats the `Authorization: Bearer` header when set to `bearer`.

---

## Authentication Schemes

Ruby supports two authentication mechanisms:

### 1. Basic Bearer Token (Recommended for Standard Integrations)
Header:
```http
Authorization: Bearer <key_id>:<key_secret>
```

#### Example cURL:
```bash
curl -X POST "https://api.rby.one/v1/links" \
  -H "Authorization: Bearer YOUR_API_KEY_ID:YOUR_API_KEY_SECRET" \
  -H "Content-Type: application/json" \
  -d '{
    "destination_url": "https://example.com/summer-promotion",
    "domain": "rby.one",
    "title": "Summer Campaign",
    "utm_source": "newsletter",
    "utm_medium": "email",
    "utm_campaign": "summer_sale",
    "forward_parameters": true
  }'
```

### 2. Enterprise HMAC-SHA256 Request Signing
For environments requiring request tamper-proofing and replay defense.

Headers:
- `X-Rby-Key-Id`: Your API Key ID (`ak_...`)
- `X-Rby-Timestamp`: Current UNIX timestamp in seconds (must be within &plusmn;60 seconds of server time)
- `X-Rby-Signature`: Hex-encoded HMAC-SHA256 signature calculated over the canonical payload

#### Canonical String-to-Sign:
```text
{timestamp}\n{METHOD}\n{path}\n{body_hash}
```
Where `{body_hash}` is the SHA-256 hex digest of the raw request body (or empty string hash `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` if no body).

---

## Code Examples

Executable code examples are provided in the [`examples/`](./examples/) directory:

- **Python**:
  - [`examples/python/create_link_bearer.py`](./examples/python/create_link_bearer.py)
  - [`examples/python/create_link_hmac.py`](./examples/python/create_link_hmac.py)
  - [`examples/python/create_group.py`](./examples/python/create_group.py)
  - [`examples/python/list_domains.py`](./examples/python/list_domains.py)
- **Node.js**:
  - [`examples/node/create_link_bearer.js`](./examples/node/create_link_bearer.js)
  - [`examples/node/create_link_hmac.js`](./examples/node/create_link_hmac.js)
  - [`examples/node/create_group.js`](./examples/node/create_group.js)
  - [`examples/node/list_domains.js`](./examples/node/list_domains.js)
- **cURL**:
  - [`examples/curl/create_link_bearer.sh`](./examples/curl/create_link_bearer.sh)
  - [`examples/curl/create_link_hmac.sh`](./examples/curl/create_link_hmac.sh)
  - [`examples/curl/create_group.sh`](./examples/curl/create_group.sh)
  - [`examples/curl/list_domains.sh`](./examples/curl/list_domains.sh)

---

## Specification & Documentation

- **OpenAPI 3.1 Specification**: [`openapi_v1.json`](./openapi_v1.json)
- **Official Documentation**: [https://docs.rby.one](https://docs.rby.one)
- **Interactive Swagger UI**: [https://docs.rby.one/api/reference/swagger/](https://docs.rby.one/api/reference/swagger/)

---

## License

This collection and its example code are licensed under the [MIT License](./LICENSE).
