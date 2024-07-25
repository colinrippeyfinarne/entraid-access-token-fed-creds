#!/bin/bash

# Create the key vault
az keyvault create --resource-group "${RESOURCE_GROUP}" \
   --location "${LOCATION}" \
   --name "${KEYVAULT_NAME}" \
   --enable-rbac-authorization false \
   --sku standard

# Create a secret for testing
az keyvault secret set --vault-name "${KEYVAULT_NAME}" \
   --name "${KEYVAULT_SECRET_NAME}" \
   --value "Generic secret for testing"

# Grant access policy to the UAMI
az keyvault set-policy --name "${KEYVAULT_NAME}" \
  --secret-permissions get \
  --object-id "${USER_ASSIGNED_MANAGED_IDENTITY_OBJECT_ID}"
