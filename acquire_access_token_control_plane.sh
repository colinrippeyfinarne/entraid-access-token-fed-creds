#!/bin/bash

# Generate a client assertion for the Azure Control Plane (scope https://management.azure.com/.default)
CONTROL_PLANE_TOKEN_REQUEST_BODY=" scope=https%3A%2F%2Fmanagement.azure.com%2F.default&\
client_id=${USER_ASSIGNED_MANAGED_IDENTITY_CLIENT_ID}&\
client_assertion_type=urn%3Aietf%3Aparams%3Aoauth%3Aclient-assertion-type%3Ajwt-bearer&\
client_assertion=${CLIENT_ASSERTION}&\
grant_type=client_credentials"

export CONTROL_PLANE_ACCESS_TOKEN=$(curl -X POST \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d ${CONTROL_PLANE_TOKEN_REQUEST_BODY} \
    'https://login.microsoftonline.com/'"$TENANT_ID"'/oauth2/v2.0/token' 2>/dev/null | jq -r '.access_token')

echo $CONTROL_PLANE_ACCESS_TOKEN

