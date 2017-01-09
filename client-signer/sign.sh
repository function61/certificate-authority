#!/bin/sh -eu

cfssl gencert -ca=ca/ca.crt -ca-key=ca/ca.key -config=ca/ca-config.json -profile=client client-signer/client.json | cfssljson -bare client-signer/signed/client

mv client-signer/signed/client.pem client-signer/signed/client.crt
mv client-signer/signed/client-key.pem client-signer/signed/client.key
rm client-signer/signed/client.csr

# this is importable to browsers & mobile devices
openssl pkcs12 -export -clcerts -in client-signer/signed/client.crt -inkey client-signer/signed/client.key -out client-signer/signed/client.p12
