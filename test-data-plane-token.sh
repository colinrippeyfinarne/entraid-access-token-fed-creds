#!/bin/bash

# We generate a fresh client assertion
JTI_UUID=$(uuidgen)
CLOUD="AzureCloud";
CORRELATION_ID=$(uuidgen)

# The $X5T variable you generated from part 1
X5T="rjB4LgAZ452Exg63TEAWYyMFrjg"

# The kid from the jwks.json file you uploaded in part 1
KEY_ID="mFyJrCgt1xiuwrC7ulsBsCbojS5Sdkl6_rYtmshlY6A"

EXPIRY="$(date '+%s')"
EXPIRYONEHOUR=$((EXPIRY+3600))

HEADER="{\"alg\":\"RS256\",\"typ\":\"JWT\",\"x5t\":\"${X5T}\",\"kid\":\"${KEY_ID}\"}"
PAYLOAD="{\"iss\": \"${SERVICE_ACCOUNT_ISSUER}\", \"sub\": \"${SERVICE_ACCOUNT_NAME}\", \"aud\": \"${TOKEN_AUDIENCE}\", \"iat\": ${EXPIRY}, \"exp\": ${EXPIRYONEHOUR}, \"jti\": \"${JTI_UUID}\"}"

TOKEN="$(printf "%s" "$HEADER" | openssl base64 -A | tr '+/' '-_' | tr -d '=').$(printf "%s" "$PAYLOAD" | openssl base64 -A | tr '+/' '-_' | tr -d '=')"

SIGN="$(printf "%s" "$TOKEN" | openssl dgst -sha256 -sign "${PRIVATE_KEY}" -binary | openssl base64 -A | tr '+/' '-_' | tr -d '=')"

# Create the final JWT
export CLIENT_ASSERTION="$TOKEN.$SIGN"

TOKEN_REQUEST_BODY=" scope=https%3A%2F%2Fvault.azure.net%2F.default&\
client_id=${USER_ASSIGNED_MANAGED_IDENTITY_CLIENT_ID}&\
client_assertion_type=urn%3Aietf%3Aparams%3Aoauth%3Aclient-assertion-type%3Ajwt-bearer&\
client_assertion=${CLIENT_ASSERTION}&\
grant_type=client_credentials"

DATA_PLANE_ACCESS_TOKEN=$(curl -X POST \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d ${TOKEN_REQUEST_BODY} \
    'https://login.microsoftonline.com/'"$TENANT_ID"'/oauth2/v2.0/token' 2>/dev/null | jq -r '.access_token')

curl -X GET \
    -H "Authorization: Bearer ${DATA_PLANE_ACCESS_TOKEN}" \
    "https://${KEYVAULT_NAME}.vault.azure.net/secrets/${KEYVAULT_SECRET_NAME}?api-version=7.4"
