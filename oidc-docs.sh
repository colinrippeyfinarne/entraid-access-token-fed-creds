
#!/bin/bash

# Generate the OIDC Discovery Document
cat > $OIDC_CONFIG <<EOF
{
  "issuer": "https://${AZURE_STORAGE_ACCOUNT}.blob.core.windows.net/${AZURE_STORAGE_CONTAINER}/",
  "jwks_uri": "https://${AZURE_STORAGE_ACCOUNT}.blob.core.windows.net/${AZURE_STORAGE_CONTAINER}/openid/v1/jwks",
  "response_types_supported": [
    "id_token"
  ],
  "subject_types_supported": [
    "public"
  ],
  "id_token_signing_alg_values_supported": [
    "RS256"
  ]
}
EOF

#  Next use the azwi command line tool to generate the jwks document.
azwi jwks --public-keys $PUBLIC_KEY --output-file $JWKS_DOC