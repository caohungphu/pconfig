#!/bin/bash

## Get ZONE_ID and RECORD_ID
CF_API_TOKEN="##_CF_API_TOKEN_##"
DOMAIN_ROOT="example.com"
DOMAIN_RECORD="subdomain.example.com"

# ZONE_ID
CF_RESPONSE=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones" \
    -H "Authorization: Bearer ${CF_API_TOKEN}" \
    -H "Content-Type: application/json" \
    -o zones.json)

ZONE_ID=$(jq -r ".result[] | select(.name == \"${DOMAIN_ROOT}\") | .id" zones.json)

# RECORD_ID
CF_RESPONSE=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records" \
    -H "Authorization: Bearer ${CF_API_TOKEN}" \
    -H "Content-Type: application/json" \
    -o dns_records.json)

RECORD_ID=$(jq -r ".result[] | select(.name == \"${DOMAIN_RECORD}\" and .type == \"A\") | .id" dns_records.json)

# Result
[ -z "${ZONE_ID}" ] && ZONE_ID="Not found"
[ -z "${RECORD_ID}" ] && RECORD_ID="Not found"
echo "ZONE_ID: ${ZONE_ID}"
echo "RECORD_ID: ${RECORD_ID}"
