#!/bin/bash

## Update DNS
CF_API_TOKEN="##_CF_API_TOKEN_##"
DOMAIN_ROOT="example.com"
DOMAIN_RECORD="subdomain.example.com"

ZONE_ID="##_ZONE_ID_##"
RECORD_ID="##_RECORD_ID_##"

PATH_IP_FILE="current_ip.txt"
NEW_IP=$(curl -s https://ifconfig.me)

update_dns() {
    CURRENT_DATE=$(TZ=GMT date +"%Y-%m-%dT%H:%M:%SZ")
    UPDATE_MSG="Updated at ${CURRENT_DATE}"
    echo "Updating DNS record A for ${DOMAIN_RECORD} -> ${NEW_IP}"
    echo -n "Response: "
    curl -sS -X PUT \
        "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
        -H "Authorization: Bearer $CF_API_TOKEN" \
        -H "Content-Type: application/json" \
        --data "{\"type\":\"A\",\"proxied\":false,\"name\":\"$DOMAIN_RECORD\",\"content\":\"$NEW_IP\",\"ttl\":120,\"comment\":\"${UPDATE_MSG}\"}"

    echo -e "\nResult: ${UPDATE_MSG}"
}

if [ ! -f "${PATH_IP_FILE}" ]; then
    echo "Not found ${PATH_IP_FILE}"
    echo -n "${NEW_IP}" >"${PATH_IP_FILE}"
    echo "Saved "${NEW_IP}" to ${PATH_IP_FILE}"
    update_dns
else
    CURRENT_IP=$(cat ${PATH_IP_FILE})
    echo "Current IP: ${CURRENT_IP}"
    echo "New IP: ${NEW_IP}"
    if [ "${CURRENT_IP}" != "${NEW_IP}" ]; then
        update_dns
        echo -n "${NEW_IP}" >"${PATH_IP_FILE}"
        echo "Saved "${NEW_IP}" to ${PATH_IP_FILE}"
    else
        echo "Result: No update"
    fi
fi

echo -e "\nCloudflare: DNS record A for ${DOMAIN_RECORD} -> ${NEW_IP}"
