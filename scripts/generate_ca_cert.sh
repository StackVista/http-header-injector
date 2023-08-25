#!/bin/bash

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
if [[ "$DIR" = "." ]]; then DIR="$PWD"; fi

echo "This helper generates a certificate and a values file to use with the header injector."

if [ "$#" != "2" ]; then
  echo "Usage: ./generate_ca_certs.sh <release_name> <namespace_name>"
  exit 1
fi

RELEASE_NAME=$1
NAMESPACE_NAME=$2
SERVICE_FQNAME="${RELEASE_NAME}-http-header-injector.${NAMESPACE_NAME}.svc"

openssl genrsa -out ca.key 2048

openssl req -x509 -new -nodes -key ca.key -subj "/CN=${SERVICE_FQNAME}" -days 10000 -out ca.crt

openssl genrsa -out tls.key 2048

( cat | SERVICE_FQNAME="$SERVICE_FQNAME" envsubst > csr.conf ) <<CSR
[ req ]
default_bits = 2048
prompt = no
default_md = sha256
req_extensions = req_ext
distinguished_name = dn

[ dn ]
C = NL
ST = Utrecht
L = Hilversum
O = StackState
OU = Dev
CN = $SERVICE_FQNAME

[ req_ext ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = $SERVICE_FQNAME

[ v3_ext ]
authorityKeyIdentifier=keyid,issuer:always
basicConstraints=CA:FALSE
keyUsage=keyEncipherment,dataEncipherment
extendedKeyUsage=serverAuth
subjectAltName=@alt_names
CSR

openssl req -new -key tls.key -out tls.csr -config "csr.conf"

openssl x509 -req -in tls.csr -CA ca.crt -CAkey ca.key \
    -CAcreateserial -out tls.crt -days 10000 \
    -extensions v3_ext -extfile "csr.conf" -sha256

# shellcheck disable=SC2002
CA_BUNDLE=$(cat ca.crt | sed -z 's/\n/\\n/g')
# shellcheck disable=SC2002
CRT=$(cat tls.crt | sed -z 's/\n/\\n/g')
# shellcheck disable=SC2002
KEY=$(cat tls.key | sed -z 's/\n/\\n/g')

( cat | CA_BUNDLE="$CA_BUNDLE" CRT="$CRT" KEY="$KEY" envsubst > tls_values.conf ) <<VALUES
httpHeaderInjectorWebhook:
  webhook:
    tls:
      mode: "provided"
      caBundle: "$CA_BUNDLE"
      crt: "$CRT"
      key: "$KEY"
VALUES

echo "CA certificate written to tls_values.conf"