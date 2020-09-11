#!/usr/bin/env bash
set -euo pipefail

openssl genrsa -des3 -out rootCA.key 4096
openssl req -x509 -new -nodes -key rootCA.key -subj '/C=CA/ST=Ontario/O=Demo/CN=Beacon Self-signed Root' -sha256 -days 1024 -out rootCA.crt

# generate IdP cert

openssl genrsa -out oidc/tls.key 2048
openssl req -new -sha256 -key oidc/tls.key -subj '/C=CA/ST=Ontario/O=Demo/CN=oidc' -out oidc/tls.csr
openssl x509 -req -in oidc/tls.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out oidc/tls.crt -days 500 -sha256
rm oidc/tls.csr

# generate LDAP cert

openssl genrsa -out ldap_mock/tls.key 2048
openssl req -new -sha256 -key ldap_mock/tls.key -subj '/C=CA/ST=Ontario/O=Demo/CN=opa' -out ldap_mock/tls.csr
openssl x509 -req -in ldap_mock/tls.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out ldap_mock/tls.crt -days 500 -sha256
rm ldap_mock/tls.csr


#### BROKER ####

openssl genrsa -des3 -out rootCA_broker.key 4096
openssl req -x509 -new -nodes -key rootCA_broker.key -subj '/C=CA/ST=Ontario/O=Demo/CN=Beacon Self-signed Root' -sha256 -days 1024 -out rootCA_broker.crt

# generate IdP cert

openssl genrsa -out broker/tls.key 2048
openssl req -new -sha256 -key broker/tls.key -subj '/C=CA/ST=Ontario/O=Demo/CN=broker' -out broker/tls.csr
openssl x509 -req -in broker/tls.csr -CA rootCA_broker.crt -CAkey rootCA_broker.key -CAcreateserial -out broker/tls.crt -days 500 -sha256
rm broker/tls.csr
