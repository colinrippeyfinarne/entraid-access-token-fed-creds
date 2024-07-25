#!/bin/bash

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

