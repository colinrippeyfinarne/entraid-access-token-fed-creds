#!/bin/bash

# Set some helper variables used throughout this post series

# Cryptographic objects
export ENTRAID_FEDCRED="entraid_fedcred"
export PRIVATE_KEY="${ENTRAID_FEDCRED}_private.key"
export PUBLIC_KEY="${ENTRAID_FEDCRED}_public.key"
export CSR_CONFIG="${ENTRAID_FEDCRED}_csr.config"
export CSR_FILE="${ENTRAID_FEDCRED}_self_signed.csr"
export SELF_SIGNED="${ENTRAID_FEDCRED}_self_signed.pem"

# Azure resources (set your own values here)
export RESOURCE_GROUP="fin-uks-wif-rg"
export LOCATION="uksouth"
export TENANT_ID="b0d4a74b-a954-468b-aa34-c6b534714a2c"

# Storage account used to host the Discovery Documents
export AZURE_STORAGE_ACCOUNT="finukswifsa"
export AZURE_STORAGE_CONTAINER="oidc-test"
export USER_ASSIGNED_MANAGED_IDENTITY_NAME="finukswifuami"

# Identity Documents
export OIDC_CONFIG="openid-configuration.json"
export JWKS_DOC="jwks.json"
export SERVICE_ACCOUNT_ISSUER="https://${AZURE_STORAGE_ACCOUNT}.blob.core.windows.net/${AZURE_STORAGE_CONTAINER}/"
export SERVICE_ACCOUNT_NAME="system:serviceaccount:generic-workload-identity-sa"
export TOKEN_AUDIENCE="api://AzureADTokenExchange"

# Azure Testing
export KEYVAULT_NAME="finukswifkv"
export KEYVAULT_SECRET_NAME="generic-secret"
