#!/bin/bash

export USER_ASSIGNED_MANAGED_IDENTITY_CLIENT_ID="$(az identity show --name "${USER_ASSIGNED_MANAGED_IDENTITY_NAME}" --resource-group "${RESOURCE_GROUP}" --query 'clientId' -otsv)"
export USER_ASSIGNED_MANAGED_IDENTITY_OBJECT_ID="$(az identity show --name "${USER_ASSIGNED_MANAGED_IDENTITY_NAME}" --resource-group "${RESOURCE_GROUP}" --query 'principalId' -otsv)"
