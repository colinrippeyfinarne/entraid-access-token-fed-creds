#!/bin/bash

az identity create --name "${USER_ASSIGNED_MANAGED_IDENTITY_NAME}" --resource-group "${RESOURCE_GROUP}"

export USER_ASSIGNED_MANAGED_IDENTITY_CLIENT_ID="$(az identity show --name "${USER_ASSIGNED_MANAGED_IDENTITY_NAME}" --resource-group "${RESOURCE_GROUP}" --query 'clientId' -otsv)"
export USER_ASSIGNED_MANAGED_IDENTITY_OBJECT_ID="$(az identity show --name "${USER_ASSIGNED_MANAGED_IDENTITY_NAME}" --resource-group "${RESOURCE_GROUP}" --query 'principalId' -otsv)"

echo "USER_ASSIGNED_MANAGED_IDENTITY_CLIENT_ID"
echo $USER_ASSIGNED_MANAGED_IDENTITY_CLIENT_ID

echo "USER_ASSIGNED_MANAGED_IDENTITY_OBJECT_ID"
echo $USER_ASSIGNED_MANAGED_IDENTITY_OBJECT_ID

# Create the associated Federated Credential
az identity federated-credential create \
  --name "generic-federated-identity" \
  --identity-name "${USER_ASSIGNED_MANAGED_IDENTITY_NAME}" \
  --resource-group "${RESOURCE_GROUP}" \
  --issuer "${SERVICE_ACCOUNT_ISSUER}" \
  --subject "${SERVICE_ACCOUNT_NAME}"
