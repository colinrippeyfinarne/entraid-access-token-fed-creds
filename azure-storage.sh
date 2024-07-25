#!/bin/bash

# Create the resource group to host the storage account
az group create --name "${RESOURCE_GROUP}" --location "${LOCATION}"

# Create the storage account (note the allow public access switch)
az storage account create --resource-group "${RESOURCE_GROUP}" --name "${AZURE_STORAGE_ACCOUNT}" --allow-blob-public-access true

# Create the storage container to host the discovery documents
az storage container create --name "${AZURE_STORAGE_CONTAINER}" --public-access blob

# Upload the discovery document
az storage blob upload \
  --container-name "${AZURE_STORAGE_CONTAINER}" \
  --file $OIDC_CONFIG \
  --name .well-known/openid-configuration

# Retrieve the document to test it has been sucessfully uploaded
curl -s "https://${AZURE_STORAGE_ACCOUNT}.blob.core.windows.net/${AZURE_STORAGE_CONTAINER}/.well-known/openid-configuration"

# Upload the jwks.json document
az storage blob upload \
  --container-name "${AZURE_STORAGE_CONTAINER}" \
  --file $JWKS_DOC \
  --name openid/v1/jwks

# Retrieve the document to test it has been sucessfully uploaded
curl -s "https://${AZURE_STORAGE_ACCOUNT}.blob.core.windows.net/${AZURE_STORAGE_CONTAINER}/openid/v1/jwks"
