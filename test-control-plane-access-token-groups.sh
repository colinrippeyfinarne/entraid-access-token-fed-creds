
#!/bin/bash

# First get the current subscription id
export CURRENT_SUBSCRIPTION_ID="$(az account show --query 'id' -otsv)"

# Now execute the REST API call
curl -X GET \
    -H "Authorization: Bearer ${CONTROL_PLANE_ACCESS_TOKEN}" \
    "https://management.azure.com/subscriptions/${CURRENT_SUBSCRIPTION_ID}/resourcegroups?api-version=2021-04-01"
