#!/bin/bash

# Generate the public/private key pair

openssl genrsa -out $PRIVATE_KEY 2048
openssl rsa -in $PRIVATE_KEY -pubout -out $PUBLIC_KEY

# Use your own values for the certificate fields
cat > $CSR_CONFIG <<EOF
[ req ]
default_bits       = 2048
default_md         = sha256
default_keyfile    = $PRIVATE_KEY
prompt             = no
distinguished_name = dn
req_extensions     = req_ext

[ dn ]
C=GB
ST=Scotland
L=Glasgow
O=Azure Services
OU=Development
emailAddress=colin.rippey@finarne.com
CN=entraidfedcreddevcert.finarne.com

[ req_ext ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = entraidfedcreddevcert.finarne.com
EOF

# Generate the self signed csr
openssl req -new -key $PRIVATE_KEY -config $CSR_CONFIG -out $CSR_FILE

# Generate the self signed from the csr
openssl x509 -in $CSR_FILE -out $SELF_SIGNED -req -signkey $PRIVATE_KEY -days 365

# Generate the SHA-1 hash (required for the X5T parameter in the client assertion)
THUMBPRINT=$(openssl x509 -in $SELF_SIGNED -fingerprint -noout -sha1 | awk -F'=' '{print $2}' | tr -d ':')
export X5T=$(echo -n $THUMBPRINT | xxd -r -p | base64 | tr '+/' '-_' | tr -d '=')
echo $X5T

