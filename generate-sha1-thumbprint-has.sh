#!/bin/bash

# Generate the SHA-1 hash (required for the X5T parameter in the client assertion)
THUMBPRINT=$(openssl x509 -in $SELF_SIGNED -fingerprint -noout -sha1 | awk -F'=' '{print $2}' | tr -d ':')
export X5T=$(echo -n $THUMBPRINT | xxd -r -p | base64 | tr '+/' '-_' | tr -d '=')
echo $X5T
