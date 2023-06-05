#!/bin/bash

set -ex

openssl genrsa -out ca.key 2048

openssl req -x509 -new -nodes -key ca.key -subj "/CN=http-header-injector.injector.svc" -days 10000 -out ca.crt

openssl genrsa -out server.key 2048

openssl req -new -key server.key -out server.csr -config csr.conf

openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key \
    -CAcreateserial -out server.crt -days 10000 \
    -extensions v3_ext -extfile csr.conf -sha256

echo "CA bundle:"
base64 -w 0 ca.crt

echo
echo "Server.crt"
base64 -w 0 server.crt

echo
echo "Server.key"
base64 -w 0 server.key
