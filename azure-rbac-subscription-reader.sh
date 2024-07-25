#!/bin/bash

# First get the current subscription id
export CURRENT_SUBSCRIPTION_ID="$(az account show --query 'id' -otsv)"

# Grant the UAMI the RBAC Reader at the Subscription scope
az role assignment create --assignee "${USER_ASSIGNED_MANAGED_IDENTITY_OBJECT_ID}" \
   --role "Reader" \
   --scope "/subscriptions/${CURRENT_SUBSCRIPTION_ID}"
